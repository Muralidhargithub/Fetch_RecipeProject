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
        let expectation = XCTestExpectation(description: "Fetch recipes should complete")
        
        mockService.shouldReturnEmpty = false
        mockService.shouldFail = false
        mockService.shouldReturnMalformed = false
        
        Task {
            await viewModel.fetchData()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2)
        XCTAssertEqual(viewModel.foodGroups.count, 2, "Should return 2 recipes")
    }
    
    func testFetchRecipes_Empty() async {
        let expectation = XCTestExpectation(description: "Fetch should return empty list")

        mockService.shouldReturnEmpty = true
        
        Task {
            await viewModel.fetchData()
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2)
        XCTAssertEqual(viewModel.foodGroups.count, 0, "Should return an empty list")
    }
    
    func testFetchRecipes_MalformedJSON() async {
        let expectation = XCTestExpectation(description: "Fetch should fail due to malformed JSON")

        mockService.shouldReturnMalformed = true
        
        Task {
            await viewModel.fetchData()
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2)
        XCTAssertEqual(viewModel.foodGroups.count, 0, "Malformed JSON should return empty list")
    }

    func testFetchRecipes_NetworkFailure() async {
        let expectation = XCTestExpectation(description: "Fetch should fail due to network issue")

        mockService.shouldFail = true
        
        Task {
            await viewModel.fetchData()
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2)
        XCTAssertEqual(viewModel.foodGroups.count, 0, "Network failure should return empty list")
    }

    func testFetchImage_Success() async {
        do {
            let image = try await mockService.fetchImages(url: "https://example.com/image.png")
            XCTAssertNotNil(image, "Image should be successfully fetched")
        } catch {
            XCTFail("Fetching image should not fail")
        }
    }

}
