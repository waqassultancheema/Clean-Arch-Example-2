//
//  StationAppRouter.swift
//  FlixAppDemo
//
//  Created by Waqas Sultan on 7/23/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit


protocol StationAppRouterView {
   func showTimeTableDetailViewController()
}
class StationAppRouter: StationAppRouterView {

    var timeTableDetailViewController:UIViewController? = nil
    var navigationController:UINavigationController? = nil
    var timeTableListViewController:TimetableListViewController? = nil
    func showTimeTableDetailViewController() {
//        let storyboard:UIStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
//        StationDetailViewController = storyboard.instantiateViewController(withIdentifier: "")
//        navigationController?.pushViewController(StationDetailViewController!, animated: true)
    }
    
}

