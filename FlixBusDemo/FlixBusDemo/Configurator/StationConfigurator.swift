//
//  StationConfigurator.swift
//  FlixAppDemo
//
//  Created by Waqas Sultan on 7/23/18.
//  Copyright © 2018 Waqas Sultan. All rights reserved.
//

import UIKit
import MaterialActivityIndicator

protocol AlertView   {
     func displayalert(title:String, message:String)
}

extension AlertView where Self: TimetableListViewController {
   
    func displayalert(title:String, message:String) {
        let alert = UIAlertController(title: title, message: "\(message) \n\nPlease Press Retry", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "Retry", style: .default, handler: { [unowned self] (action) -> Void in
           
            self.indicator.startAnimating()
            self.output.fetchItems()
            alert.dismiss(animated: true, completion: nil)
            
        })))
        self.present(alert, animated: true, completion: nil)
        
        
    }
}
extension TimetableListViewController: StationPresenterOutput , AlertView
{
    func successFetchedTimetable(viewModel: ViewModel.DisplayViewModel) {
        self.displayViewModel = viewModel
        self.tableViewDataSource.displayViewModels = viewModel.deperature
        DispatchQueue.main.async {
            self.tableViewDataSource.selectTransitType(selectedType: 0)
            self.tableView.reloadData()
            self.indicator.stopAnimating()
        }
    }
    
    func errorWhileFetchingTimetable(error: String) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.indicator.stopAnimating()
            self.displayalert(title: "Error", message: error)
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // open next view controller from here
       // router.passDataToNextScene(segue: segue)
    }
}

extension StationInteractor: TimetableListViewControllerOutput
{
    func fetchItems() {
          StationConfigurator.sharedInstance.interactor.fetchTimetable()
    }


}

extension StationPresenter: StationInteractorOutput
{
    func passedToPresentFetchedTimetable(timetable: Timetable) {
        StationConfigurator.sharedInstance.presenter.presentFetchTimetable(timeTable: timetable)

    }
    
    
    func errorWhileFetchTimetable(error: String) {
        StationConfigurator.sharedInstance.presenter.presentFetchedError(error: error)
    }
    
   
}

class StationConfigurator: NSObject {

    static let sharedInstance = StationConfigurator()
    let presenter = StationPresenter()
    let interactor = StationInteractor()
    let router = StationAppRouter()

    private override init() {}

    // MARK: - Configuration

    func configure(viewController: TimetableListViewController)
    {
        router.timeTableListViewController = viewController


        presenter.output = viewController
        

        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }
}
