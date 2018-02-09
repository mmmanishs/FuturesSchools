//
//  NycSchool.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation

class NycSchool: Codable {
    var school_name: String?
    var requirement1_1  : String?
    var school_email: String?
    var school_sports: String?
    var city: String?
    var extracurricular_activities: String?
    var building_code: String?
    var ell_programs: String?
    var finalgrades: String?
    var latitude: String?
    var longitude: String?
    var location: String?
    var overview_paragraph: String?
    var website: String?
    var total_students: String?
    var dbn: String?
    var num_of_sat_test_takers: String?
    var sat_critical_reading_avg_score: String?
    var sat_math_avg_score: String?
    var sat_writing_avg_score: String?
    
    
    //It would be nice to get some unit test around this
    func merge(school:NycSchool) -> Bool {
        if self.dbn == school.dbn {
            self.num_of_sat_test_takers = school.num_of_sat_test_takers
            self.sat_critical_reading_avg_score = school.sat_critical_reading_avg_score
            self.sat_math_avg_score = school.sat_math_avg_score
            self.sat_writing_avg_score = school.sat_writing_avg_score
            return true
        }
        return false
    }
}
