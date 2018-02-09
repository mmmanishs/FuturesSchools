//
//  Router.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/8/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import UIKit

//The purpose of the router is to act like a hub whose responsibility is to "Route" the ViewControllers
enum Router<T> where T: UIViewController  {
    case schoolDetail(NycSchool, T)
    case openWebsite(URL)
    func route() {
        switch self {
        case .schoolDetail(let school, let viewController):
            let viewModel = SchoolDetailsViewModel(school: school)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let schoolDetailsViewController = storyboard.instantiateViewController(withIdentifier: "SchoolDetailsViewController") as? SchoolDetailsViewController {
                schoolDetailsViewController.viewModel = viewModel
                viewController.navigationController?.pushViewController(schoolDetailsViewController, animated: true)
            }
        case .openWebsite(let url):
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}
