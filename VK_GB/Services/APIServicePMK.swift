//
//  APIServicePMK.swift
//  VK_GB
//
//  Created by Павел Черняев on 10.08.2021.
//

import Foundation
import PromiseKit

enum ErrGroup: Error {
    case errMakeUrlConstructor
    case badURL
}

//вынес в отдельный сервис, т.к. PromiseKit v6 ломает Swift Result 
class APIServicePMK: APIService {
    
    func getGroups() -> Promise<[Group]> {
        let path = "/method/groups.get"
        let  queryItems = [
            URLQueryItem(name: "extended", value: "1"),
        ]
        guard let urlConstructor = makeURLConstructor(path, queryItems) else { return Promise.init(error: ErrGroup.errMakeUrlConstructor) }
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        guard let url = urlConstructor.url else { return Promise.init(error: ErrGroup.badURL) }
        return firstly {
            session.dataTask(.promise, with: url)
        }.compactMap { (data: Data, response: URLResponse) in
            let groupResponse = try? JSONDecoder().decode(GroupResponse.self, from: data)
            guard let groups = groupResponse?.response.items else { return [] }
            return groups
        }
    }
}
