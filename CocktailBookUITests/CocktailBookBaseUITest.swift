//
//  BaseUITest.swift
//  CocktailBookBaseUITest
//
//  Created by Sandeep Negi on 31/08/24.
//

import XCTest

class CocktailBookBaseUITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func wait(interval: TimeInterval = 5) {
        let exp = expectation(description: "UI_Test_Case_Waiter")
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
            exp.fulfill()
        }
        waitForExpectations(timeout: interval + 1)
    }
}
