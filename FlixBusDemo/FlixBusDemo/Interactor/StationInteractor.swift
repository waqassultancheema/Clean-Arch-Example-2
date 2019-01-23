//
//  StationInteractor.swift
//  FlixAppDemo
//
//  Created by Waqas Sultan on 7/23/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit

protocol StationInteractorInput {

    func fetchTimetable()
}

protocol StationInteractorOutput {
    func passedToPresentFetchedTimetable(timetable:Timetable)
    func errorWhileFetchTimetable(error:String)


}
class StationInteractor:StationInteractorInput {

    var output: StationInteractorOutput!
    var worker: StationRemoteWorker = StationRemoteWorker()
    
    func fetchTimetable() {
        worker.fetchStations( complete: { [unowned self] (station) in
            self.output.passedToPresentFetchedTimetable(timetable: station.timetable)
        }) { (error) in
            self.output.errorWhileFetchTimetable(error: error ?? "Error Occured While Fetching From Server")

        }
        
       }

}
