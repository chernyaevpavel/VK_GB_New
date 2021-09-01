//
//  GetDataOperation.swift
//  VK_GB
//
//  Created by Павел Черняев on 03.08.2021.
//

import Foundation

class GetDataOperation: AsyncOperation {
    private var task: URLSessionTask?
    var data: Data?
    
    override func cancel() {
        task?.cancel()
        super.cancel()
    }
    
    override func main() {
        task?.resume()
    }
    
    init(_ path: String, _ queryItems: [URLQueryItem]) {
        super.init()
        let apiService = APIService()
        guard let urlConstructor = apiService.makeURLConstructor(path, queryItems) else { return }
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        self.task = session.dataTask(with: urlConstructor.url!) {[weak self] (data, response, error) in
            guard let dataResp = data else { return }
            self?.data = dataResp
            self?.state = .finished
        }
        
    }
}
