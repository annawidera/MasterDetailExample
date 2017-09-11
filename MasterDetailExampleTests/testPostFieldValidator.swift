//
//  testPostFieldValidator.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 11.09.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import XCTest
@testable import MasterDetailExample

class testPostFieldsValidator: XCTestCase {
    
    let postFieldsValidator = PostValidator()
    let postFieldValidationTimeout = 2.0
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    
    func testTitleCorrectValidation() {
        let expectTitleLong = expectation(description: "Title was long enough")
        let expectTitleWithSpaces = expectation(description: "Title has spaces inside")
        let expectReallyShort = expectation(description: "Title could not have only one letter")
        
        postFieldsValidator.validate(title: "giulietta") { (title, status) in
            XCTAssert(status == .correct, "giulietta is correct")
            XCTAssert(title == "giulietta", "title on the output should be the same as on the input")
            
            expectTitleLong.fulfill()
        }
        
        let songTitle = "My heart will go on"
        postFieldsValidator.validate(title: songTitle) { (title, status) in
            XCTAssert(status == .correct, "\(songTitle) is correct")
            XCTAssert(title == songTitle, "Title on the output should be the same as on the in put")
            
            expectTitleWithSpaces.fulfill()
        }
        
        let z = "Z"
        postFieldsValidator.validate(title: z) { (title, status) in
            XCTAssert(status == .tooShort, "\(z) is incorrect, tooShort")
            XCTAssert(title == z, "title on the output should be the same as on the in put")
            
            expectReallyShort.fulfill()
        }
        
        waitForExpectations(timeout: postFieldValidationTimeout) { (error) in
            if (error != nil) {
                print(#function)
                print(error?.localizedDescription ?? "no description")
            }
        }
    }
    
}
