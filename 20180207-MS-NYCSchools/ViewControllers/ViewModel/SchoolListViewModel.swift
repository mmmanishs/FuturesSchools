//
//  SchoolListViewModel.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

class SchoolListViewModel {
    var schools: [NycSchool]?
    var showError: Bool
    init(schools:[NycSchool]?, showError: Bool) {
        self.schools = schools
        self.showError = showError
    }
}
