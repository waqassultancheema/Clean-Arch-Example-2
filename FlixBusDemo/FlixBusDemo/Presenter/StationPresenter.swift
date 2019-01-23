//
//  StationPresenter.swift
//  FlixAppDemo
//
//  Created by Waqas Sultan on 7/23/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//


import UIKit
protocol StationPresenterInput
{
    func presentFetchTimetable(timeTable:Timetable)
    func presentFetchedError(error:String)
}

protocol StationPresenterOutput: class
{
    func successFetchedTimetable(viewModel: ViewModel.DisplayViewModel)
    func errorWhileFetchingTimetable(error:String)
}
class StationPresenter:StationPresenterInput {
 
    var output:StationPresenterOutput!
    
    func presentFetchTimetable(timeTable: Timetable) {
        if output != nil {
            if timeTable.departures.count == 0 {
                output.errorWhileFetchingTimetable(error: "No Departures Found")
            }
            if timeTable.arrivals.count == 0 {
                output.errorWhileFetchingTimetable(error: "No Arrivals Found")
            }
            
            let arrivaldisplayModel =  convertDataIntoViewModel(list: timeTable.arrivals)
            let deperaturedisplayModel =  convertDataIntoViewModel(list: timeTable.departures)
            
            let viewModel = ViewModel.DisplayViewModel(arrivals: arrivaldisplayModel, deperature: deperaturedisplayModel)
            
            output.successFetchedTimetable(viewModel:viewModel)
        }
       

    }
    
    func presentFetchedError(error: String) {
         output.errorWhileFetchingTimetable(error: error)
    }
    
    
    
    
    func getTimetableViewModel(list:[Transit],onlyDate:String) -> ViewModel.DisplayViewModel.TimeTableViewModel {
        
        var routeDetail:[ViewModel.DisplayViewModel.RouteViewModel] = []
        _ = list.filter { (iteminner) -> Bool in
            
            let date:Date = Date(timeIntervalSince1970: TimeInterval(iteminner.datetime.timestamp))
            let  timeZoneDate = date.convertToLocalTime(fromTimeZone: iteminner.datetime.tz) != nil ? date.convertToLocalTime(fromTimeZone: iteminner.datetime.tz)! : date
            
            if timeZoneDate.toString(dateStyle: .short, timeStyle: .none) == onlyDate {
                
                let onlyTime = timeZoneDate.toString(dateStyle: .none, timeStyle: .short)
                let routerView = ViewModel.DisplayViewModel.RouteViewModel(time: onlyTime, lineNumber: iteminner.lineDirection, briefRoute: iteminner.throughTheStations)
                routeDetail.append(routerView)
            }
            return false
        }
        
        let timetableViewModel:ViewModel.DisplayViewModel.TimeTableViewModel = ViewModel.DisplayViewModel.TimeTableViewModel(routeDetail: routeDetail, date: onlyDate)
        return timetableViewModel
    }
   
    func convertDataIntoViewModel(list:[Transit]) -> [ViewModel.DisplayViewModel.TimeTableViewModel] {
        
        var displayViewModels:[ViewModel.DisplayViewModel.TimeTableViewModel] = []
        
        for item in list {

            var date:Date = Date(timeIntervalSince1970: TimeInterval(item.datetime.timestamp))
            date = date.convertToLocalTime(fromTimeZone: item.datetime.tz) != nil ? date.convertToLocalTime(fromTimeZone: item.datetime.tz)! : date
            let onlyDate = date.toString(dateStyle: .short, timeStyle: .none)
            if displayViewModels.filter({ $0.date == onlyDate }).count == 0 || displayViewModels.filter({ $0.date == onlyDate }).first == nil {
                let timetableViewModel:ViewModel.DisplayViewModel.TimeTableViewModel = getTimetableViewModel(list: list, onlyDate: onlyDate)
                displayViewModels.append(timetableViewModel)
            }
        }
        return displayViewModels
    }
}


