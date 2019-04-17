//
//  APIClient.swift
//  Weather
//
//  Created by udn on 2019/4/17.
//  Copyright © 2019 dengli. All rights reserved.
//

import Foundation


class APIManager {
    
    typealias ResultCompletion = (Result<Data?, Error>) -> Void
    
    var defaultSession: DHURLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    // Swift 5
    func getData(from urlString: String, completion: @escaping ResultCompletion) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = defaultSession.dataTask(with: url) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(data))
            }
        }

        task.resume()
    }
    
    func getData(from urlString: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            completion(data, response, error)
        }
        
        task.resume()
    }
}
