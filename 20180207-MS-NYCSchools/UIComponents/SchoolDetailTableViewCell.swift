//
//  SchoolTableViewCell.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import UIKit

class SchoolDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var left: UILabel!
    @IBOutlet weak var right: UILabel!
    func setDataToCell(cellValue: CellValue) {
        left.text = cellValue.left
        right.text = cellValue.right ?? "n.a."
        switch cellValue.cellProperty {
        case .openSafari, .openEmail:
            self.accessoryType = .disclosureIndicator
        default:
            self.accessoryType = .none

        }
    }
}
