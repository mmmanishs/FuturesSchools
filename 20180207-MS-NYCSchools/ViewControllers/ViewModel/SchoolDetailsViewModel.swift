//
//  SchoolDetailsViewModel.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

class SchoolDetailsViewModel {
    private var school: NycSchool
    var dataSource: [CellValue]
    init(school: NycSchool) {
        self.school = school
        dataSource = [CellValue]()
        dataSource.append(CellValue(left: "School Name", right: school.school_name, cellProperty: .none))
        dataSource.append(CellValue(left: "Critical reading average score", right: school.sat_critical_reading_avg_score, cellProperty: .none))
        dataSource.append(CellValue(left: "Maths average score", right: school.sat_math_avg_score, cellProperty: .none))
        dataSource.append(CellValue(left: "Writing average score", right: school.sat_writing_avg_score, cellProperty: .none))
        dataSource.append(CellValue(left: "Requirements", right: school.requirement1_1, cellProperty: .none))
        dataSource.append(CellValue(left: "School Sport", right: school.school_sports, cellProperty: .none))
        dataSource.append(CellValue(left: "Extracurricular Activities", right: school.extracurricular_activities, cellProperty: .none))
        dataSource.append(CellValue(left: "Building Code", right: school.building_code, cellProperty: .none))
        dataSource.append(CellValue(left: "Website", right: school.website, cellProperty: .openSafari))
        dataSource.append(CellValue(left: "Email", right: school.school_email, cellProperty: .openEmail))
    }
}

struct CellValue {
    var left: String
    var right: String?
    var cellProperty: CellProperty
}

enum CellProperty {
    case none
    case openSafari
    case openEmail
}
