//
//  Fetch_RecipeProjectTests.swift
//  Fetch_RecipeProjectTests
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//

import XCTest
@testable import Fetch_RecipeProject

final class Fetch_RecipeProjectTests: XCTestCase {
    
    var mockService: MockApiService!
        var viewModel: RecipeViewModel!
        
        override func setUp() {
            super.setUp()
            mockService = MockApiService()
            viewModel = RecipeViewModel(networkManager: mockService)
        }
        
        override func tearDown() {
            mockService = nil
            viewModel = nil
            super.tearDown()
        }
        
        func testFetchRecipes_Success() async {
            await viewModel.fetchData()
            XCTAssertEqual(viewModel.foodGroups.count, 2, "✅ Should return 2 recipes")
        }
        
        func testFetchRecipes_Empty() async {
            mockService.shouldReturnEmpty = true
            await viewModel.fetchData()
            XCTAssertTrue(viewModel.foodGroups.isEmpty, "✅ Should return an empty list")
        }
        
        func testFetchRecipes_MalformedJSON() async {
            mockService.shouldReturnMalformed = true
            await viewModel.fetchData()
            XCTAssertTrue(viewModel.foodGroups.isEmpty, "✅ Should discard malformed JSON")
        }
    }
