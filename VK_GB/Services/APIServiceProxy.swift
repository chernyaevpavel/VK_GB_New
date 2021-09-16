//
//  APIServiceProxy.swift
//  VK_GB
//
//  Created by Павел Черняев on 16.09.2021.
//

import Foundation

class APIServiceProxy: APIServiceProtocol {
    let apiService: APIServiceProtocol
    
    init(_ apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func getFriends(completion: @escaping ([User]) -> ()) {
        self.apiService.getFriends { users in
            completion(users)
        }
        log(functionName: #function)
    }
    
    func getGroups(completion: @escaping ([Group]) -> ()) {
        self.apiService.getGroups { groups in
            completion(groups)
        }
        log(functionName: #function)
    }
    
    func getPhotos(ownerID: String, completion: @escaping ([Photo]) -> ()) {
        self.apiService.getPhotos(ownerID: ownerID) { photos in
            completion(photos)
        }
        log(functionName: #function)
    }
    
    func getNews(completion: @escaping (Result<[News], ApiError>) -> ()) {
        self.apiService.getNews { result in
            completion(result)
        }
        log(functionName: #function)
    }
      
    func makeURLConstructor(_ path: String, _ queryItems: [URLQueryItem]) -> URLComponents? {
        return self.apiService.makeURLConstructor(path, queryItems)
        log(functionName: #function)
    }
    
    func downloadImage(from url: URL, completion: @escaping (Data) -> ()) {
        self.apiService.downloadImage(from: url) { data in
            completion(data)
        }
        log(functionName: #function)
    }
    
    func getUserName(userID: String, completion: @escaping (Result<[String : String], ApiError>) -> ()) {
        self.apiService.getUserName(userID: userID) { result in
            completion(result)
        }
        log(functionName: #function)
    }
    
    func getGroupName(groupID: String, completion: @escaping (Result<[String : String], ApiError>) -> ()) {
        self.apiService.getGroupName(groupID: groupID) { result in
            completion(result)
        }
        log(functionName: #function)
    }
    
    private func log(functionName: String) {
        print("APIServiceProxy run ",functionName)
    }
}
