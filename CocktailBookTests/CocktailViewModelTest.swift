//
//  CocktailViewModelTest.swift
//  CocktailBookTests
//
//  Created by Sandeep Negi on 31/08/24.
//

import XCTest
@testable import CocktailBookAPIFramework
@testable import CocktailBook

final class CocktailViewModelTest: CocktailBookBaseUnitTest {

    override func setUpWithError() throws {
        CocktailFavoriteManager.instanse.clearAll()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessResponse() throws {
        let viewModel = CocktailViewModel(apiCaller: FakeCocktailsAPI())
        
        let expectation = self.expectation(description: "Success Response Unit Test")
        
        viewModel.fetch { status, error in
            XCTAssertTrue(status == true, "TestSuccessResponse: CocktailViewModel status check failed")
            XCTAssertNil(error, "TestSuccessResponse: CocktailViewModel error check failed")
            
            XCTAssertFalse(viewModel.cocktailList?.isEmpty ?? true, "TestSuccessResponse: CocktailViewModel item array check failed")
            
            XCTAssertFalse(viewModel.cocktailList?.first?.id?.isEmpty ?? true, "TestSuccessResponse: CocktailViewModel item id check failed")
            XCTAssertFalse(viewModel.cocktailList?.first?.name?.isEmpty ?? true, "TestSuccessResponse: CocktailViewModel item name failed")
            XCTAssertFalse(viewModel.cocktailList?.first?.type?.rawValue.isEmpty ?? true, "TestSuccessResponse: CocktailViewModel item type check failed")
            XCTAssertFalse(viewModel.cocktailList?.first?.shortDescription?.isEmpty ?? true, "TestSuccessResponse: CocktailViewModel item short description check failed")
            XCTAssertFalse(viewModel.cocktailList?.first?.longDescription?.isEmpty ?? true, "TestSuccessResponse: CocktailViewModel item long description check failed")
            XCTAssertFalse(viewModel.cocktailList?.first?.imageName?.isEmpty ?? true, "TestSuccessResponse: CocktailViewModel item image name check failed")
            XCTAssertFalse(viewModel.cocktailList?.first?.ingredients?.isEmpty ?? true, "TestSuccessResponse: CocktailViewModel item ingredent array check failed")
            XCTAssertFalse(viewModel.cocktailList?.first?.ingredients?.first?.isEmpty ?? true, "TestSuccessResponse: CocktailViewModel item ingredent first element check failed")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }

    func testFailureResponse() throws {
        let viewModel = CocktailViewModel(apiCaller: FakeCocktailsAPI(withFailure: .count(1)))
        
        let expectation = self.expectation(description: "Failure Response Unit Test")
        
        viewModel.fetch { status, error in
            XCTAssertTrue(status == false, "TestFailureResponse: CocktailViewModel status check failed")
            XCTAssertNotNil(error, "TestFailureResponse: CocktailViewModel error check failed")
            XCTAssertFalse(error?.description.isEmpty ?? true, "")
            
            XCTAssertTrue(viewModel.cocktailList?.isEmpty ?? true, "TestFailureResponse: CocktailViewModel item array check failed")
            
            XCTAssertTrue(viewModel.cocktailList?.first?.id?.isEmpty ?? true, "TestFailureResponse: CocktailViewModel item id check failed")
            XCTAssertTrue(viewModel.cocktailList?.first?.name?.isEmpty ?? true, "TestFailureResponse: CocktailViewModel item name failed")
            XCTAssertTrue(viewModel.cocktailList?.first?.type?.rawValue.isEmpty ?? true, "TestFailureResponse: CocktailViewModel item type check failed")
            XCTAssertTrue(viewModel.cocktailList?.first?.shortDescription?.isEmpty ?? true, "TestFailureResponse: CocktailViewModel item short description check failed")
            XCTAssertTrue(viewModel.cocktailList?.first?.longDescription?.isEmpty ?? true, "TestFailureResponse: CocktailViewModel item long description check failed")
            XCTAssertTrue(viewModel.cocktailList?.first?.imageName?.isEmpty ?? true, "TestFailureResponse: CocktailViewModel item image name check failed")
            XCTAssertTrue(viewModel.cocktailList?.first?.ingredients?.isEmpty ?? true, "TestFailureResponse: CocktailViewModel item ingredent array check failed")
            XCTAssertTrue(viewModel.cocktailList?.first?.ingredients?.first?.isEmpty ?? true, "TestFailureResponse: CocktailViewModel item ingredent first element check failed")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }

    func testAddAndRemoveFavorite() throws {
        let viewModel = CocktailViewModel(apiCaller: FakeCocktailsAPI())
        
        let expectation = self.expectation(description: "Success Response Unit Test")
        
        viewModel.fetch { status, error in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        
        
        let favoriteId = "1"
        viewModel.addToFavorite(id: favoriteId)
        
        wait(interval: 2)
        
        // ADD Favorite
        //Positive Test Case
        XCTAssertTrue(CocktailFavoriteManager.instanse.isFavorite(id: favoriteId), "TestAddAndRemoveFavorite: Add favorite check failed")
        //Negative Test Case
        XCTAssertFalse(CocktailFavoriteManager.instanse.isFavorite(id: "2"), "TestAddAndRemoveFavorite: Negative Add favorite check failed")
        
        viewModel.removeFromFavorite(id: favoriteId)
        wait(interval: 2)
        
        //REMOVE Favorite
        //Positive Test Case
        XCTAssertFalse(CocktailFavoriteManager.instanse.isFavorite(id: favoriteId), "TestAddAndRemoveFavorite: Remove favorite check failed")
    }
}
