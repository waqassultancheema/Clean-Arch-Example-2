//
//  DummyRemoteWorker.swift
//  FlixBusDemoTests
//
//  Created by Waqas Sultan on 7/26/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import XCTest
@testable import FlixBusDemo

class DummyRemoteWorker: StationRemoteWorker {

      var mockResponse:String = ""
    
    override func fetchStations( complete :@escaping (Station) -> Void, failure:@escaping (String?) -> Void) {
        
        do {
            let response = try Station(mockResponse)
            complete(response)
        } catch  {
            failure(error.localizedDescription)
        }
    }
}
