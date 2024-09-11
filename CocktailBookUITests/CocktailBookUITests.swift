import XCTest
@testable import CocktailBook



class CocktailBookUITests: CocktailBookBaseUITest {

    override func setUpWithError() throws {
        clearFavoriteCache()
    }

    override func tearDownWithError() throws {
    }

    // NOTE: This method will be used when retry feature is enabled for demo
    func processRetryClick() {
        
        let alertErrorCocktailRetryButton = XCUIApplication().alerts["Error"].scrollViews.otherElements.buttons["alert_error_cocktail_retry"]
        if alertErrorCocktailRetryButton.exists {
            alertErrorCocktailRetryButton.tap()
            wait()
            
            /*
             // When try count is 2
             alertErrorCocktailRetryButton.tap()
             wait()
             // When try count is 3
             alertErrorCocktailRetryButton.tap()
             wait()
             */
        }
    }
    
    func testAllValidDataWithRetry() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        wait()
        
        processRetryClick()
        
        let tablesQuery = app.tables
        
        let tableView1 = tablesQuery.containing(.table, identifier: TestAppConstants.Accessibility.tvCocktailTable)
        XCTAssertTrue(tableView1.cells.count > 0, "TestAllValidDataWithRetry All Cocktail data available failed")
        
        app.segmentedControls[TestAppConstants.Accessibility.scCocktailOptions].buttons.element(boundBy: 1).tap()
        wait(interval: 2)
        
        let tableView2 = tablesQuery.containing(.table, identifier: TestAppConstants.Accessibility.tvCocktailTable)
        XCTAssertTrue(tableView2.cells.count > 0, "TestAllValidDataWithRetry Alcoholic Cocktail data available failed")
        
        app.segmentedControls[TestAppConstants.Accessibility.scCocktailOptions].buttons.element(boundBy: 2).tap()
        wait(interval: 2)
        
        let tableView3 = tablesQuery.containing(.table, identifier: TestAppConstants.Accessibility.tvCocktailTable)
        XCTAssertTrue(tableView3.cells.count > 0, "TestAllValidDataWithRetry Non-Alcoholic Cocktail data available failed")
    }
    
    func testDetailPageOpeningAndAddToFavorite() throws {
        let app = XCUIApplication()
        app.launch()
        
        wait()
        
        processRetryClick()
        
        let tableView1 = app.tables.containing(.table, identifier: TestAppConstants.Accessibility.tvCocktailTable)
        XCTAssertTrue(tableView1.cells.count > 0, "TestDetailPageOpeningAndAddToFavorite cocktail table cell count check failed")
        
        let clickFirstCocktailItem = tableView1.cells.element(boundBy: 0)
        clickFirstCocktailItem.tap()
        
        wait(interval: 2)
        
        let tableView2 = app.tables.containing(.table, identifier: TestAppConstants.Accessibility.tvDetailTable)
        XCTAssertTrue(tableView2.cells.count > 0, "TestDetailPageOpeningAndAddToFavorite detail table cell count check failed")
        
        tableView2.firstMatch.swipeUp()
        
        wait(interval: 2)
        
        let backButton = XCUIApplication().navigationBars.buttons[TestAppConstants.Accessibility.detailNavigationBackButton]
        XCTAssertNotNil(backButton, "TestDetailPageOpeningAndAddToFavorite back button check failed")
        
        let favoriteButton = XCUIApplication().navigationBars.buttons[TestAppConstants.Accessibility.detailNavigationFavoriteButton]
        XCTAssertNotNil(favoriteButton, "TestDetailPageOpeningAndAddToFavorite favorite button check failed")
        
        favoriteButton.tap()
        
        wait(interval: 2)
        
        backButton.tap()
        
        wait(interval: 2)
        
        let tableView3 = app.tables.containing(.table, identifier: TestAppConstants.Accessibility.tvCocktailTable)
        XCTAssertTrue(tableView3.cells.count > 0, "TestDetailPageOpeningAndAddToFavorite cocktail table cell count re-check failed")
        
        tableView3.firstMatch.swipeDown()
        
        wait(interval: 2)
        
        let firstCocktailItemFavorite = tableView1.cells.element(boundBy: 0)
        let favoriteIcon = firstCocktailItemFavorite.images[TestAppConstants.Accessibility.cocktailCellFavoriteImage]
        XCTAssertNotNil(favoriteIcon, "TestDetailPageOpeningAndAddToFavorite favorite button existance check failed")
    }
    
    func testAPIFirstFailureWithOkAction() throws {
        let app = XCUIApplication()
        app.launch()
        
        wait()
        
        let alertOk = XCUIApplication().alerts["Error"].scrollViews.otherElements.buttons["alert_error_cocktail_ok"]
        
        if alertOk.exists {
            alertOk.tap()
            
            let tablesQuery = app.tables
            let tableView1 = tablesQuery.containing(.table, identifier: TestAppConstants.Accessibility.tvCocktailTable)
            XCTAssertTrue(tableView1.cells.count <= 0, "TestAPIFirstFailureWithOkAction All Cocktail TableView cell count zero Failed")
            
            app.segmentedControls[TestAppConstants.Accessibility.scCocktailOptions].buttons.element(boundBy: 1).tap()
            wait(interval: 2)
            
            let tableView2 = tablesQuery.containing(.table, identifier: TestAppConstants.Accessibility.tvCocktailTable)
            XCTAssertTrue(tableView2.cells.count <= 0, "TestAPIFirstFailureWithOkAction Alcoholic Cocktail TableView cell count zero Failed")
            
            app.segmentedControls[TestAppConstants.Accessibility.scCocktailOptions].buttons.element(boundBy: 2).tap()
            wait(interval: 2)
            
            let tableView3 = tablesQuery.containing(.table, identifier: TestAppConstants.Accessibility.tvCocktailTable)
            XCTAssertTrue(tableView3.cells.count <= 0, "TestAPIFirstFailureWithOkAction Non-Alcoholic Cocktail TableView cell count zero Failed")
        } else {
            let tablesQuery = app.tables
            
            let tableView1 = tablesQuery.containing(.table, identifier: TestAppConstants.Accessibility.tvCocktailTable)
            XCTAssertTrue(tableView1.cells.count > 0, "TestAllValidDataWithRetry All Cocktail data available failed")
        }
    }
    
    func testNavigationTitleChange() throws {
        let app = XCUIApplication()
        app.launch()
        
        wait()
        
        let alertOk = XCUIApplication().alerts["Error"].scrollViews.otherElements.buttons["alert_error_cocktail_ok"]
        if alertOk.exists {
            alertOk.tap()
        }
        
        let item1 = XCUIApplication().navigationBars.staticTexts["All Cocktails"]
        XCTAssertNotNil(item1, "TestNavigationTitleChange title \"All Cocktails\" failed")
        
        app.segmentedControls[TestAppConstants.Accessibility.scCocktailOptions].buttons.element(boundBy: 1).tap()
        wait(interval: 2)
        
        let item2 = XCUIApplication().navigationBars.staticTexts["Alcoholic Cocktails"]
        XCTAssertNotNil(item2, "TestNavigationTitleChange title \"Alcoholic Cocktails\" failed")
        
        app.segmentedControls[TestAppConstants.Accessibility.scCocktailOptions].buttons.element(boundBy: 2).tap()
        wait(interval: 2)
        
        let item3 = XCUIApplication().navigationBars.staticTexts["Non-Alcoholic Cocktails"]
        XCTAssertNotNil(item3, "TestNavigationTitleChange title \"Non-Alcoholic Cocktails\" failed")
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
