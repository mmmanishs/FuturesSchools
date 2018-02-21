//
//  RemoteDataController.swift
//  20180207-MS-NYCSchools
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import Foundation
import Alamofire
import Promises
enum APIError: Error {
    case apiError
}
//Result with help us neatly deal with success/error scenarios in completion block.
//Cannot throw so using Results enum
enum Result<T> {
    case success(T)
    case failure(APIError)
}

//Any object can now act as a data provider if they Adhere to this protocol
protocol DataProvider {
    func getSchoolsData() -> Promise<[NycSchool]>
}


class RemoteDataController: DataProvider {
    func getSchoolsData() -> Promise<[NycSchool]> {
        let endPoint: String = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
        return Promise { fullfil, reject in
            Alamofire.request(endPoint)
                .responseData() { response in
                    if let data = response.result.value {
                        let decoder = JSONDecoder()
                        do {
                            let nycSchools = try decoder.decode([NycSchool].self, from: data) as [NycSchool]
                            fullfil(nycSchools)
                            
                        } catch {
                            reject(error)
                        }
                    } else {
                        reject(APIError.apiError)
                    }
            }
        }
        
    }
    
    func getSchoolSATData(completionHandler: @escaping(Result<[NycSchool]>) ->()) { //Url needs to be passed as param
        let endPoint: String = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
        Alamofire.request(endPoint)
            .responseData() { response in
                if let data = response.result.value {
                    let decoder = JSONDecoder()
                    do {
                        let nycSchools = try decoder.decode([NycSchool].self, from: data) as [NycSchool]
                        completionHandler(Result.success(nycSchools))
                        
                    } catch {
                        print("error trying to convert data to JSON")
                        print(error)
                        completionHandler(Result.failure(APIError.apiError))
                    }
                } else {
                    completionHandler(Result.failure(APIError.apiError))
                }
        }
    }
}




