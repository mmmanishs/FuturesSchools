//
//  SchoolDetailsViewController.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit
import MessageUI
class SchoolDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel: SchoolDetailsViewModel?
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SchoolDetailsViewController {
    //Would like to move the datasource and delegates to seperate classes so that this ViewController is not that clutered
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.dataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SchoolDetailTableViewCell", for: indexPath) as? SchoolDetailTableViewCell {
            guard let dataSource = self.viewModel?.dataSource else {
                return UITableViewCell()
            }
            cell.setDataToCell(cellValue: dataSource[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let dataSource = self.viewModel?.dataSource else {
            return
        }
        switch dataSource[indexPath.row].cellProperty {
        case .openSafari:
            if let urlString = dataSource[indexPath.row].right,
                let url = URL(string: "http://" + urlString) {
                Router.openWebsite(url).route()
            }
        case .openEmail: //This can go in a router as well. Also this part is not tested on a real device
            if MFMailComposeViewController.canSendMail() {
                let email = MFMailComposeViewController()
                email.setToRecipients([dataSource[indexPath.row].right ?? ""])
                self.present(email, animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
}

