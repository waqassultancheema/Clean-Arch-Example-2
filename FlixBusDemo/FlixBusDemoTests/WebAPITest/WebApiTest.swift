//
//  RemoteWorkerTest.swift
//  FlixBusDemoTests
//
//  Created by Waqas Sultan on 7/26/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import XCTest
@testable import FlixBusDemo

class WebApiTest: XCTestCase {
    let dummyWebApi:DummyWebApi = DummyWebApi()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetURLWithString() {
        let url = "http://api.mobile.staging.mfb.io/mobile/v1/network/station/1/timetable"
        self.dummyWebApi.getDataFromServer(url: url, completion: { (response, error) in
            
        })
        XCTAssert(url == self.dummyWebApi.lastURL)
    }
    
    func testGetResumeCalled() {
        
        let url = "http://api.mobile.staging.mfb.io/mobile/v1/network/station/1/timetable"
        self.dummyWebApi.getDataFromServer(url: url, completion: { (response, error) in
            
        })
        if let resumeCalled = self.dummyWebApi.task?.resumeWasCalled{
            XCTAssert(resumeCalled)
        } else {
            XCTFail("Resume  not Called")

        }
    }
    
    func testServiceError() {
        
        let url = "http://api.mobile.staging.mfb.io/mobile/v1/network/station/1/timetable"
        self.dummyWebApi.getDataFromServer(url: url, completion: { (response, error) in
            if let errror = error {
                XCTAssertNotNil(errror)
            } else {
                XCTFail("No Error Came")
            }
        })
    }
    
    
    func testServiceWithNoInternetError() {
        
        let url = "http://api.mobile.staging.mfb.io/mobile/v1/network/station/1/timetable"
        DummyReachability.isConnected  = false
        self.dummyWebApi.getDataFromServer(url: url, completion: { (response, error) in
            if let errror = error {
                XCTAssertEqual(errror.localizedDescription, "Please check your internet connection.")
            } else {
                XCTFail("No Error Came")
            }
        })
    }
    
    func testServiceUnknownError() {
        
        let url = "http://api.mobile.staging.mfb.io/mobile/v1/network/station/1/timetable"
        
       
        self.dummyWebApi.getDataFromServer(url: url, completion: { (response, error) in
            if let errror = error {
                     XCTAssertEqual(errror.localizedDescription, Parsing.unKnown)
            } else {
                XCTFail("No Error Came")
            }
        })
        
    }
    
    func testService403Error() {
        
        let url = "http://api.mobile.staging.mfb.io/mobile/v1/network/station/1/timetable"
        self.dummyWebApi.dummyData = DummyResponse.authentic403Response.data(using: .utf8)
        self.dummyWebApi.dummyResponse =  HTTPURLResponse(url: URL(string: url)!, statusCode: 403, httpVersion: "HTTP/1.1", headerFields: nil)
        self.dummyWebApi.getDataFromServer(url: url, completion: { (response, error) in
            if let errror = error {
                
                XCTAssertEqual(errror.localizedDescription, "You do not have the necessary permissions.")
            } else {
                 XCTFail("No Error Came")
            }
        })
        
    }
    
    func testService200() {
        
        let url = "http://api.mobile.staging.mfb.io/mobile/v1/network/station/1/timetable"
        self.dummyWebApi.dummyData = DummyResponse.validResponse.data(using: .utf8)
        self.dummyWebApi.dummyResponse =  HTTPURLResponse(url: URL(string: url)!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)
        self.dummyWebApi.getDataFromServer(url: url, completion: { (response, error) in
            if let _ = error {
                XCTFail("Error should not come")
            } else {
                XCTAssert(response != nil)
            }
        })
        
    }

    
    
}
