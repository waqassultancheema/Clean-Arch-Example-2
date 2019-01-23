//
//  StationRemoteApi.swift
//  FlixAppDemo
//
//  Created by Waqas Sultan on 8/23/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//



import UIKit
let APIURLPrefix = "http://api.mobile.staging.mfb.io/"
let station = 1

class StationRemoteWorker: NSObject,WebAPIHandler {
   
     private var requestURLString = "\(APIURLPrefix)mobile/v1/network/station/\(station)/timetable"
    
    func fetchStations( complete :@escaping (Station) -> Void, failure:@escaping (String?) -> Void) {
        
        getDataFromServer(url: requestURLString) { (response, error) in
            guard error == nil else {
                failure(error?.localizedDescription)
                return
            }
            
            if let mData = response as? Data {
                
                do {
                    let response = try Station(data: mData)
                    complete(response)
                } catch  {
                    failure(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
    
    
    
}
