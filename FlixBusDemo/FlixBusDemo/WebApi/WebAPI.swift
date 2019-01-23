//
//  WebAPI.swift
//  FlixAppDemo
//
//  Created by Waqas Sultan on 7/26/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit
import Foundation

typealias onCompletion = (Any?, NetworkError?)->()




protocol WebAPIHandler {
    func getDataFromServer(url: String,completion: @escaping onCompletion)
}

extension WebAPIHandler {
    
    func getDataFromServer(url: String,completion: @escaping onCompletion) {
        
        guard Reachability.isConnectedToNetwork() else {
            completion(nil, NetworkError.noNetwork)
            return
        }
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        if let urL = URL(string: urlString) {
            var request = URLRequest(url: urL)
             request.addValue("intervIEW_TOK3n", forHTTPHeaderField: "X-Api-Authentication")
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) -> Void in
                ParserURLResponse.parseURLResponse(response: response, data: data, completion: completion,error: error)
            }
            task.resume()
        }
    }
    
    
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func stationTask(with url: URL, completionHandler: @escaping (Station?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}





