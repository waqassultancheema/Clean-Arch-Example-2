//
//  MockURLSession.swift
//  FlixBusDemoTests
//
//  Created by Waqas Sultan on 7/26/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import XCTest
import UIKit
import Foundation
@testable import FlixBusDemo


//MARK: MOCK
struct DummyResponse {
   static let authentic403Response:String = "{\"code\":403,\"message\":\"You do not have the necessary permissions.\"}"
   static let validResponse:String = "{ \"timetable\": { \"arrivals\": [ { \"through_the_stations\": \"Hildesheim → Salzgitter → Brunswick → Helmstedt → Magdeburg → Berlin central bus station\", \"datetime\": { \"timestamp\": 1532351400, \"tz\": \"GMT+02:00\" }, \"line_direction\": \"Route 151 direction Berlin central bus station\", \"ride_id\": 62291098, \"line_code\": \"L151\", \"direction\": \"Berlin central bus station\" } ], \"departures\": [ { \"through_the_stations\": \"Berlin central bus station → Berlin TXL, A/B → Szczecin Warzymice → Szczecin station\", \"datetime\": { \"timestamp\": 1532351700, \"tz\": \"GMT+02:00\" }, \"line_direction\": \"Route 057 direction Szczecin station\", \"ride_id\": 69646418, \"line_code\": \"L057\", \"direction\": \"Szczecin station\" } ], \"message\": \"\" } }"
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    private (set) var resumeWasCalled = false

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override func resume() {
        resumeWasCalled = true

        closure()
    }
}


class MockURLSession: URLSession {
   
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    var nextData: Data?
    var nextError: Error?
    var nextResponse:URLResponse?
    
    private (set) var lastURL: URL?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastURL = url
        let data = nextData
        let response = nextResponse
        let error = nextError
        return MockURLSessionDataTask {
            completionHandler(data, response, error)
        }
    }
  
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        lastURL = request.url
        let data = nextData
        let response = nextResponse
        let error = nextError
        return MockURLSessionDataTask {
            completionHandler(data, response, error)
        }    }
    
}
