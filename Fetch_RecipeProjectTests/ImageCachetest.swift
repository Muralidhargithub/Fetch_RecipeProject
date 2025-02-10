//
//  RecipeApiServiceTests.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/10/25.
//

import XCTest
@testable import Fetch_RecipeProject
import UIKit

final class ImageCacheTests: XCTestCase {

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

    func testFetchAndCacheImage_Success() async {
        let imageURL = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"

        do {
            let image1 = try await mockService.fetchImages(url: imageURL)
            XCTAssertNotNil(image1, "Image should be fetched successfully")

            let image2 = try await mockService.fetchImages(url: imageURL)
            XCTAssertNotNil(image2, "Image should be retrieved from cache")

            XCTAssertEqual(image1.pngData(), image2.pngData(), "Images should be identical, indicating caching works")
        } catch {
            XCTFail("Image fetch failed: \(error)")
        }
    }

    func testFetchImage_FromDiskCache() async {
        let imageURL = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b6efe075-6982-4579-b8cf-013d2d1a461b/small.jpg"

        do {
            let _ = try await mockService.fetchImages(url: imageURL)

            let cachedImage = try await mockService.fetchImages(url: imageURL)
            XCTAssertNotNil(cachedImage, "Image should be loaded from disk cache")
        } catch {
            XCTFail("Failed to load image from disk cache: \(error)")
        }
    }

    func testFetchImage_InvalidImageData() async {
        let invalidURL = "https://example.com/invalid-image.jpg"
        
        mockService.shouldFail = true

        do {
            _ = try await mockService.fetchImages(url: invalidURL)
            XCTFail("Fetching an invalid image should fail")
        } catch NetworkError.networkFailure {
            XCTAssertTrue(true, "Correctly threw networkFailure error")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testFetchImage_NetworkFailure() async {
        let badURL = "https://thisdoesnotexist.com/image.png"
        
        mockService.shouldFail = true

        do {
            _ = try await mockService.fetchImages(url: badURL)
            XCTFail("Fetching image from an invalid URL should fail")
        } catch NetworkError.networkFailure {
            XCTAssertTrue(true, "Correctly threw networkFailure error")
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
