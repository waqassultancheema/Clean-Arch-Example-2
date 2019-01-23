//
//  PresenterTest.swift
//  FlixBusDemoTests
//
//  Created by Waqas Sultan on 7/28/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import XCTest
@testable import FlixBusDemo

class PresenterTest: XCTestCase {
    
    let dummyRemoteWorker:DummyRemoteWorker = DummyRemoteWorker()
    let interactor:StationInteractor = StationInteractor()
    var timetable:Timetable?
    var viewModel:ViewModel.DisplayViewModel?
    let presenter:StationPresenter = StationPresenter()
    override func setUp() {
        super.setUp()
        interactor.output = self
        presenter.output = self
        interactor.worker = dummyRemoteWorker
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTimetableIfNil() {
        interactor.fetchTimetable()
        XCTAssertNil(timetable)
        
    }
    func testTimetableIsNotNil() {
        dummyRemoteWorker.mockResponse = "{\"timetable\": {\"arrivals\": [],\"departures\": [],\"message\": \"\"}}"
        interactor.fetchTimetable()
        XCTAssertNotNil(timetable)

    }
    
    func testViewModelIsPopulatedFromTimeTable() {
        dummyRemoteWorker.mockResponse = "{\"timetable\": {\"arrivals\": [],\"departures\": [],\"message\": \"\"}}"
        interactor.fetchTimetable()
        XCTAssertNotNil(viewModel)

    }
    
    func testFailureViewModelIsPopulatedFromTimeTable() {
        interactor.fetchTimetable()
        XCTAssertNil(viewModel)
        
    }
//
}

extension PresenterTest:StationInteractorOutput {
    func passedToPresentFetchedTimetable(timetable: Timetable) {
        self.timetable = timetable
        self.presenter.presentFetchTimetable(timeTable: timetable)
    }
    
    func errorWhileFetchTimetable(error: String) {
        
    }
    
    
}

extension PresenterTest:StationPresenterOutput {
    func successFetchedTimetable(viewModel: ViewModel.DisplayViewModel) {
        self.viewModel = viewModel
    }
    
    func errorWhileFetchingTimetable(error: String) {
        
    }
    
    
}
