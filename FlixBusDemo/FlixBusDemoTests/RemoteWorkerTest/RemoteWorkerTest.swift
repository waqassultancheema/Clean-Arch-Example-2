//
//  RemoteWorkerTest.swift
//  FlixBusDemoTests
//
//  Created by Waqas Sultan on 7/27/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import XCTest
@testable import FlixBusDemo

class RemoteWorkerTest: XCTestCase {
    
    let dummyRemoteWorker:DummyRemoteWorker = DummyRemoteWorker()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testFailureStationModelFromJSON() {
        
    
        self.dummyRemoteWorker.fetchStations(complete: { (station) in
            
        }) { (error) in
            XCTAssertEqual(error, "The data couldn’t be read because it isn’t in the correct format.")
        }
    }
    
    func testStationModelFromJSON() {
        
            self.dummyRemoteWorker.mockResponse = "{ \"timetable\": { \"arrivals\": [ { \"through_the_stations\": \"Hildesheim → Salzgitter → Brunswick → Helmstedt → Magdeburg → Berlin central bus station\", \"datetime\": { \"timestamp\": 1532351400, \"tz\": \"GMT+02:00\" }, \"line_direction\": \"Route 151 direction Berlin central bus station\", \"ride_id\": 62291098, \"line_code\": \"L151\", \"direction\": \"Berlin central bus station\" } ], \"departures\": [ { \"through_the_stations\": \"Berlin central bus station → Berlin TXL, A/B → Szczecin Warzymice → Szczecin station\", \"datetime\": { \"timestamp\": 1532351700, \"tz\": \"GMT+02:00\" }, \"line_direction\": \"Route 057 direction Szczecin station\", \"ride_id\": 69646418, \"line_code\": \"L057\", \"direction\": \"Szczecin station\" } ], \"message\": \"\" } }"
        self.dummyRemoteWorker.fetchStations(complete: { (station) in
            XCTAssertNotNil(station)
        }) { (error) in
            XCTFail(error ?? "Model Not Made")
        }
    }
    
    
    func testFailureTimetableModelFromJSON() {
        
        self.dummyRemoteWorker.mockResponse = "{\"timetable\": {}}"
        self.dummyRemoteWorker.fetchStations(complete: { (station) in
        }) { (error) in
            XCTAssertEqual(error, "The data couldn’t be read because it is missing.")
        }
    }
    
    func testTimetableModelFromJSON() {
        
        self.dummyRemoteWorker.mockResponse = "{ \"timetable\": { \"arrivals\": [ { \"through_the_stations\": \"Hildesheim → Salzgitter → Brunswick → Helmstedt → Magdeburg → Berlin central bus station\", \"datetime\": { \"timestamp\": 1532351400, \"tz\": \"GMT+02:00\" }, \"line_direction\": \"Route 151 direction Berlin central bus station\", \"ride_id\": 62291098, \"line_code\": \"L151\", \"direction\": \"Berlin central bus station\" } ], \"departures\": [ { \"through_the_stations\": \"Berlin central bus station → Berlin TXL, A/B → Szczecin Warzymice → Szczecin station\", \"datetime\": { \"timestamp\": 1532351700, \"tz\": \"GMT+02:00\" }, \"line_direction\": \"Route 057 direction Szczecin station\", \"ride_id\": 69646418, \"line_code\": \"L057\", \"direction\": \"Szczecin station\" } ], \"message\": \"\" } }"
        self.dummyRemoteWorker.fetchStations(complete: { (station) in
            XCTAssertNotNil(station.timetable)
        }) { (error) in
            XCTFail(error ?? "Model Not Made")
        }
    }
    
    func testFailureArrivalCountModelFromJSON() {
        
        self.dummyRemoteWorker.mockResponse = "{\"timetable\": {\"arrivals\": [],\"departures\": [],\"message\": \"\"}}"
        self.dummyRemoteWorker.fetchStations(complete: { (station) in
            XCTAssertEqual(station.timetable.arrivals.count, 0)
        }) { (error) in
            XCTFail(error ?? "Model Not Made")
        }
    }
    
    func testFailureDeperatureCountModelFromJSON() {
        
        self.dummyRemoteWorker.mockResponse = "{\"timetable\": {\"arrivals\": [],\"departures\": [],\"message\": \"\"}}"
        self.dummyRemoteWorker.fetchStations(complete: { (station) in
            XCTAssertEqual(station.timetable.departures.count, 0)
        }) { (error) in
            XCTFail(error ?? "Model Not Made")
        }
    }
    
}
