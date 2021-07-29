//
//  VK_API.swift
//  VK_GB
//
//  Created by Павел Черняев on 21.06.2021.
//

import Foundation
import Alamofire
import DynamicJSON

final class APIService {
    private let sheme = "https"
    private let host = "api.vk.com"
    private let versionAPI = "5.131"
    
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
            URLQueryItem(name: "fields", value: "photo_200_orig, online")
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
                //                print(data?.prettyJSON)
                let photoResponse = try? JSONDecoder().decode(PhotoResponse.self, from: dataResp)
                guard let photos = photoResponse?.response.items else { return }
                DispatchQueue.main.async {
                    completion(photos)
                }
            }
            task.resume()
        }
    }
    
    //    func groupsSearch(textSearchRequest q: String) {
    //        let path = "/method/groups.search"
    //        let queryItems = [
    //            URLQueryItem(name: "q", value: q),
    //            URLQueryItem(name: "type", value: "group")
    //        ]
    //        makeURLConstructor(path, queryItems)
    //    }
    
    private func makeURLConstructor(_ path: String, _ queryItems: [URLQueryItem]) -> URLComponents? {
        guard let sessionToken = getSessionToken() else { return nil }
        var urlConstructor = URLComponents()
        urlConstructor.scheme = sheme
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
    
    func getNews(completion: @escaping(Result<[News], ApiError>)->()) {
        guard let sessionToken = getSessionToken() else { return }
        let path = "/method/newsfeed.get"
        let url = sheme + "://" + host + path
        let maxPhotos = "10"
        let countNews = "50"
        let parameters = [
            "access_token": sessionToken,
            "filters": "post",
            "max_photos": maxPhotos,
            "count" : countNews,
            "v": versionAPI
        ]
        
        DispatchQueue.global().async {
            AF.request(url, method: .get , parameters: parameters).responseData { response in
                DispatchQueue.global().async {
                    if let error = response.error {
                        let apiErr = ApiError(code: nil, description: error.localizedDescription)
                        DispatchQueue.main.async {
                            completion(.failure(apiErr))
                        }
                        return
                    }
                    let json = JSON(response.data)
                    if let errorCode = json.error.error_code.int,
                       let errorDescription = json.error.error_msg.string {
                        let error = ApiError(code: errorCode, description: errorDescription)
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                        return
                    }
                    var news: [News] = []
                    if let items = json.response.items.array {
                        for item in items {
                            news.append(News(data: item))
                        }
                    }
                    DispatchQueue.main.async {
                        completion(.success(news))
                    }
                }
            }
        }
    }
    
    func getUserName(userID: String, completion: @escaping(Result<[String: String], ApiError>)->()) {
        guard let sessionToken = getSessionToken() else { return }
        let path = "/method/users.get"
        let url = sheme + "://" + host + path
        let parameters = [
            "user_ids": userID,
            "access_token": sessionToken,
            "v": versionAPI
        ]
        
        DispatchQueue.global().async {
            AF.request(url, method: .get , parameters: parameters).responseData { response in
                DispatchQueue.global().async {
                    if let error = response.error {
                        let apiErr = ApiError(code: nil, description: error.localizedDescription)
                        DispatchQueue.main.async {
                            completion(.failure(apiErr))
                        }
                        return
                    }
                    let json = JSON(response.data)
                    if let errorCode = json.error.error_code.int,
                       let errorDescription = json.error.error_msg.string {
                        let error = ApiError(code: errorCode, description: errorDescription)
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                        return
                    }
                    var namesDictionary = [String: String]()
                    if let response = json.response.array {
                        for resp in response {
                            let name = resp.name.string ?? ""
                            let id = resp.id.string ?? ""
                            namesDictionary["\(id)"] = name
                        }
                    }
                    DispatchQueue.main.async {
                        completion(.success(namesDictionary))
                    }
                }
            }
        }
    }
    
    func getGroupName(groupID: String, completion: @escaping(Result<[String: String], ApiError>)->()) {
        guard let sessionToken = getSessionToken() else { return }
        let path = "/method/groups.getById"
        let url = sheme + "://" + host + path
        let parameters = [
            "group_ids": groupID,
            "access_token": sessionToken,
            "v": versionAPI
        ]
        
        DispatchQueue.global().async {
            AF.request(url, method: .get , parameters: parameters).responseData { response in
                DispatchQueue.global().async {
                    if let error = response.error {
                        let apiErr = ApiError(code: nil, description: error.localizedDescription)
                        DispatchQueue.main.async {
                            completion(.failure(apiErr))
                        }
                        return
                    }
                    let json = JSON(response.data)
                    if let errorCode = json.error.error_code.int,
                       let errorDescription = json.error.error_msg.string {
                        let error = ApiError(code: errorCode, description: errorDescription)
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                        return
                    }
                    var namesDictionary = [String: String]()
//                    var nameGroup = ""
                    if let response = json.response.array {
                        for resp in response {
                            let name = resp.name.string ?? ""
                            let id = resp.id.string ?? ""
                            namesDictionary["-\(id)"] = name
                        }
                    }
                    DispatchQueue.main.async {
                        completion(.success(namesDictionary))
                    }
                }
            }
        }
    }
}

