//
//  Fetch_RecipeProjectUITests.swift
//  Fetch_RecipeProjectUITests
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


import XCTest

final class Fetch_RecipeProjectUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }


    func testRecipeList_ShowsRecipes() {
        let firstRecipe = app.staticTexts.element(boundBy: 0)
        XCTAssertTrue(firstRecipe.waitForExistence(timeout: 10), "At least one recipe should be visible")
    }
    
    @MainActor
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
