//
//  TimetableRequest.swift
//  FlixBusDemo
//
//  Created by Waqas Sultan on 7/23/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit


    struct ViewModel {
        
        
        struct DisplayViewModel {
            struct RouteViewModel {
                var time:String = ""
                var lineNumber:String = ""
                var briefRoute:String = ""
            }
            struct TimeTableViewModel {
                var routeDetail:[RouteViewModel]
                var date:String = ""
            }
            var arrivals:[DisplayViewModel.TimeTableViewModel]
            var deperature:[DisplayViewModel.TimeTableViewModel]
        }
        
        
    }

