//
//  TimetableListViewController.swift
//  FlixBusDemo
//
//  Created by Waqas Sultan on 7/23/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit
import MaterialActivityIndicator

protocol TimetableListViewControllerOutput
{
    func fetchItems()
}

class TimetableListViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var indicator:MaterialActivityIndicatorView!

    
    var output: TimetableListViewControllerOutput!
    var router: StationAppRouter!
    var tableViewDataSource:TimetableTableViewDataSource!
    var displayViewModel:ViewModel.DisplayViewModel!
    override func awakeFromNib() {
        super.awakeFromNib()
        StationConfigurator.sharedInstance.configure(viewController: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator = MaterialActivityIndicatorView(frame: CGRect(x: self.view.center.x - 25, y: self.view.center.y - 25, width: 50, height: 50))
            indicator.color = UIColor(red: 114.0/255.0, green: 215.0/255.0, blue: 1.0/255.0, alpha: 1)
        self.view.addSubview(indicator)
        
        tableViewDataSource  = TimetableTableViewDataSource()
        tableViewDataSource.selectTransitType(selectedType: 0)
        tableView.delegate = tableViewDataSource
        tableView.dataSource = tableViewDataSource
        self.indicator.startAnimating()
        self.output.fetchItems()
       
        // Do any additional setup after loading the view.
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - IBACtion
    @IBAction func btnSwitchTapped(_ sender: Any) {
        
        if self.displayViewModel != nil {
            let button:UIButton = sender as! UIButton
            button.isSelected = !button.isSelected
            if button.isSelected {
                tableViewDataSource.displayViewModels = displayViewModel.arrivals
                tableViewDataSource.selectTransitType(selectedType: 1)
                
            } else {
                tableViewDataSource.displayViewModels = displayViewModel.deperature
                tableViewDataSource.selectTransitType(selectedType: 0)
            }
             tableView.reloadData()
        }
        
       

    }
}
