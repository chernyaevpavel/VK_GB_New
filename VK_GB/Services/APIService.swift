//
//  VK_API.swift
//  VK_GB
//
//  Created by Павел Черняев on 21.06.2021.
//

import Foundation

final class APIService {
    private let scheme = "https"
    private let host = "api.vk.com"
    private let versionAPI = "5.68"
    
    private func getSessionToken() -> String? {
        let sessionToken = Session.shared.token
        if sessionToken.isEmpty {
            print("Не удалось получить ключ доступа к приложению")
            return nil
        }
        return sessionToken
    }
    
    func getFriends(completion: @escaping([User])->()) {
        let path = "/method/friends.get"
        let queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "nickname, domain, sex, bdate, city, country, timezone, photo_50, photo_100, photo_200_orig, has_mobile, contacts, education, online, relation, last_seen, status, can_write_private_message, can_see_all_posts, can_post, universities")
        ]
        if let urlConstructor = makeURLConstructor(path, queryItems) {
            let configuration = URLSessionConfiguration.default
            let session =  URLSession(configuration: configuration)
            let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
                guard let dataResp = data else { return }
                let friendsResponse = try? JSONDecoder().decode(Friends.self, from: dataResp)
                guard let users = friendsResponse?.response.items else { return }
                
                DispatchQueue.main.async {
                    completion(users)
                }
            }
            task.resume()
        }
    }
    
    func getGroups(completion: @escaping([Group])->()) {
        let path = "/method/groups.get"
        let  queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "city, country, place, description, wiki_page, members_count, counters, start_date, finish_date, can_post, can_see_all_posts, activity, status, contacts, links, fixed_post, verified, site, can_create_topic")
        ]
        
        if let urlConstructor = makeURLConstructor(path, queryItems) {
            let configuration = URLSessionConfiguration.default
            let session =  URLSession(configuration: configuration)
            let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
                guard let dataResp = data else { return }
                let groupResponse = try? JSONDecoder().decode(GroupResponse.self, from: dataResp)
                guard let groups = groupResponse?.response.items else { return }
                DispatchQueue.main.async {
                    completion(groups)
                }
            }
            task.resume()
        }
    }
    
    func getPhotos(ownerID: String, completion: @escaping([Photo])->()){
        let path = "/method/photos.getAll"
        let queryItems = [
            URLQueryItem(name: "owner_id", value: ownerID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "offset", value: ""),
            URLQueryItem(name: "count", value: "200"),
            URLQueryItem(name: "photo_sizes", value: "0"),
            URLQueryItem(name: "no_service_albums", value: "0"),
            URLQueryItem(name: "need_hidden", value: "0"),
            URLQueryItem(name: "skip_hidden", value: "1")
        ]
        
        if let urlConstructor = makeURLConstructor(path, queryItems) {
            let configuration = URLSessionConfiguration.default
            let session =  URLSession(configuration: configuration)
            let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
                guard let dataResp = data else { return }
//                print(dataResp.prettyJSON)
                let photoResponse = try? JSONDecoder().decode(PhotoResponse.self, from: dataResp)
                guard let photos = photoResponse?.response.items else { return }
                DispatchQueue.main.async {
                    completion(photos)
                }
            }
            task.resume()
        }
    }
    
    func groupsSearch(textSearchRequest q: String) {
        let path = "/method/groups.search"
        let queryItems = [
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "type", value: "group")
        ]        
        makeURLConstructor(path, queryItems)
    }
    
    private func makeURLConstructor(_ path: String, _ queryItems: [URLQueryItem]) -> URLComponents? {
        guard let sessionToken = getSessionToken() else { return nil }
        var urlConstructor = URLComponents()
        urlConstructor.scheme = scheme
        urlConstructor.host = host
        urlConstructor.path = path
        urlConstructor.queryItems =  [URLQueryItem(name: "access_token", value: sessionToken)] + queryItems + [URLQueryItem(name: "v", value: versionAPI)]
        
        return urlConstructor
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        session.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping(Data) -> ()) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}

