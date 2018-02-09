//
//  _0180207_MS_NYCSchoolsTests.swift
//  20180207-MS-NYCSchoolsTests
//
//  Created by Manish Singh on 2/7/18.
//  Copyright © 2018 Manish Singh. All rights reserved.
//

import XCTest
@testable import _0180207_MS_NYCSchools

class _0180207_MS_NYCSchoolsTests: XCTestCase {
    var remoteDataController: RemoteDataController?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        remoteDataController = RemoteDataController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        remoteDataController = nil
    }
    
    func testAPI1() {
        let expectation = self.expectation(description: "Testing the NYC High Schools API service")

        guard let remoteDataController = remoteDataController else {
            XCTFail("Failure to initialize remoteDataController")
            return
        }
        remoteDataController.getSchoolsData() { result in
            switch result {
            case .success(let nycSchools):
                XCTAssertNotNil(nycSchools, "API returned null data")
            case .failure(let error):
                switch error {
                case .apiError:
                    XCTFail("API Failed")
                    
                }
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }
    
    func testAPI2() {
        let expectation = self.expectation(description: "Testing the NYC High Schools API service")
        
        guard let remoteDataController = remoteDataController else {
            XCTFail("Failure to initialize remoteDataController")
            return
        }
        remoteDataController.getSchoolSATData() { result in
            switch result {
            case .success(let nycSchools):
                XCTAssertNotNil(nycSchools, "API returned null data")
            case .failure(let error):
                switch error {
                case .apiError:
                    XCTFail("API Failed")
                    
                }
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5.0)
    }
}
