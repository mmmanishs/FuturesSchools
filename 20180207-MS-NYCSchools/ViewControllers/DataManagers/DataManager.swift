//
//  DataManager.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Promises
class DataManager {
    
    //Data manager hides the RemoteDataController from the view classes. This would help if lets say we need data from a Local Data Storage instead..!
    func getViewModel() -> Promise<SchoolListViewModel>  {
        let returnPromise = Promise<SchoolListViewModel>.pending()
        let promise = RemoteDataController().getSchoolsData()
            promise.then() { schools in
                returnPromise.fulfill(SchoolListViewModel(schools: schools, showError: false))
                }.catch() {error in
                    returnPromise.reject(error)
        }
        return returnPromise
    }
    
    func updateDataModelsWithSATScores(schools:[NycSchool], completion:@escaping(Result<[NycSchool]>) -> ()) {
        RemoteDataController().getSchoolSATData() { result in
            switch result {
            case .success(let nycSchools):
                completion(Result.success(self.mergeData(schoolList1: schools, schoolList2: nycSchools)))
                
            case .failure(let error):
                switch error {
                case .apiError:
                    completion(Result.failure(APIError.apiError))
                }
            }
        }
    }
    
    func mergeData(schoolList1: [NycSchool], schoolList2: [NycSchool]) -> [NycSchool] {
        var schoolList = [NycSchool]()
        for school1 in schoolList1 {
            for school2 in schoolList2 {
                if school1.merge(school: school2) {
                    schoolList.append(school1)
                    break
                }
            }
        }
        return schoolList
    }
}

