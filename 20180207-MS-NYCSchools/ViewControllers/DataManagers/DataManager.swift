//
//  DataManager.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
class DataManager {
    
    //Data manager hides the RemoteDataController from the view classes. This would help if lets say we need data from a Local Data Storage instead..!
    func getViewModel(completion:@escaping(SchoolListViewModel) -> ()) {
        RemoteDataController().getSchoolsData() { result in
            switch result {
            case .success(let nycSchools):
                //I want to use Operartion queue with dependencies here to run both tasks parallely. This will reduce API call time, and will result in much etter performance and less bugs (Lack of time to design)
                //Basically API 1 and API 2 will be called simultaneouslty and will be dependent on each other for the merge data function to call. The UI would be displayed as soon as the API call for the main list data finishes.
                //I regret not putting this solution in place. In a rush
                self.updateDataModelsWithSATScores(schools: nycSchools) { result in
                    switch result {
                    case .success(let nycSchools):
                        let viewModel = SchoolListViewModel(schools: nycSchools, showError: false)
                        completion(viewModel)
                    case .failure( _) :
                        let viewModel = SchoolListViewModel(schools: nil, showError: true)
                        completion(viewModel)                    }
                }
                
            case .failure(let error):
                switch error {
                case .apiError:
                    let viewModel = SchoolListViewModel(schools: nil, showError: true)
                    completion(viewModel)
                }
            }
        }
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

