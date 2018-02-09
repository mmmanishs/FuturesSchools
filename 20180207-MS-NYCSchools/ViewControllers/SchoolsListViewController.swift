//
//  SchoolsListViewController.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit

class SchoolsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let navigationTitleText = "NYC High Schools"
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel: SchoolListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = navigationTitleText
        refreshDataOnViewController()
    }
    
    func refreshDataOnViewController() {
        isDataLoading(isLoading: true)
        self.tableview.alpha = 0.5
        DispatchQueue.global().async {
            DataManager().getViewModel() { [unowned self] viewModel in
                self.viewModel = viewModel
                DispatchQueue.main.async {
                    if viewModel.showError {
                        //Show some error screen (Lack of time, to develop one. So a comment has to suffice)
                    } else {
                        self.isDataLoading(isLoading: false)
                        self.tableview.reloadData()
                        self.tableview.alpha = 1.0
                    }
                }
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Would like to move the datasource and delegates to seperate classes so that this ViewController is not that clutered
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.schools?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolTableViewCell", for: indexPath) as? SchoolTableViewCell {
            guard let schools = viewModel?.schools else {
                return UITableViewCell()
            }
            cell.setDataToCell(school: schools[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let school = viewModel?.schools?[indexPath.row] else {
            return
        }
        Router.schoolDetail(school, self).route()
    }
    
    @IBAction func reloadData(_ sender: Any) {
        refreshDataOnViewController()
    }
}

extension SchoolsListViewController {
    func isDataLoading(isLoading: Bool) {
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = !isLoading
        }
    }
}
