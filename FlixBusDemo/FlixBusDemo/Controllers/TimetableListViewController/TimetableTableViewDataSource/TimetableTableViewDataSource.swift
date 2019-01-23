//
//  TimetableTableViewDataSource.swift
//  FlixBusDemo
//
//  Created by Waqas Sultan on 7/23/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit

class TimetableTableViewDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    var displayViewModels:[ViewModel.DisplayViewModel.TimeTableViewModel] = []
    var headerColor:UIColor = UIColor.lightGray
    
    func selectTransitType(selectedType:Int) {
        if selectedType == 1 {
            headerColor  = UIColor(red: 251.0/255.0, green: 210.0/255.0, blue: 3.0/255.0, alpha: 1)
        } else {
            headerColor  = UIColor.lightGray
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let routeDetails = displayViewModels[section]
        return routeDetails.date

    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
            view.tintColor = headerColor
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = UIColor.white
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:TimetableTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TimetableTableViewCell", for: indexPath) as! TimetableTableViewCell
        
        let routeDetails = displayViewModels[indexPath.section].routeDetail

        
        cell.labelBriefRoute.text = routeDetails[indexPath.row].briefRoute
        cell.labelTime.text = routeDetails[indexPath.row].time
        cell.labelLineNumber.text = routeDetails[indexPath.row].lineNumber

        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return displayViewModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let routeDetail = displayViewModels[section].routeDetail
        return routeDetail.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    

    
}
