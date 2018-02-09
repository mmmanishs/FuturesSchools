//
//  SchoolTableViewCell.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    @IBOutlet weak var schoolName: UILabel!
    func setDataToCell(school: NycSchool) {
        schoolName.text = school.school_name
    }
}
