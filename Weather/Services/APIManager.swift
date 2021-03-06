//
//  APIClient.swift
//  Weather
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import Foundation


class APIManager {
    
    enum APIError: Error {
        case invalidURL
        case requestFailed
    }
    
    typealias ResultCompletion = (Result<Data, Error>) -> Void
    
    let defaultSession: DHURLSession
    
    init(session: DHURLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.defaultSession = session
    }
    
    func getData(from urlString: String, headers: [String: String]? = nil, completion: @escaping ResultCompletion) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        headers?.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        let task = defaultSession.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
        
    }
    
    func getData(from urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(nil, nil, APIError.invalidURL)
            return
        }
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        
        task.resume()
    }
}
