//
//  DummyWebApi.swift
//  FlixBusDemoTests
//
//  Created by Waqas Sultan on 7/26/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import XCTest
@testable import FlixBusDemo


class DummyReachability: Reachability {
    static var isConnected = true
    override class func isConnectedToNetwork() -> Bool {
        return isConnected
        
    }
}

class DummyWebApi:WebAPIHandler  {

    private (set) var lastURL: String?
    private (set) var task:MockURLSessionDataTask?
    var dummyData: Data?
    var dummyResponse:URLResponse?
    var dummyError:Error?
    let session = MockURLSession()
    
    
    func getDataFromServer(url: String,completion: @escaping onCompletion) {
        
        guard DummyReachability.isConnectedToNetwork() else {
            completion(nil, NetworkError.noNetwork)
            return
        }
        
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        if let urL = URL(string: urlString) {
            lastURL = urlString
            var request = URLRequest(url: urL)
            request.addValue("intervIEW_TOK3n", forHTTPHeaderField: "X-Api-Authentication")
            session.nextError = dummyError
            session.nextResponse = dummyResponse
            session.nextData = dummyData
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                    ParserURLResponse.parseURLResponse(response: response, data: data, completion: completion,error: error)

            }) as? MockURLSessionDataTask
            task?.resume()
        }
    }
}
