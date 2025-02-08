//
//  MockURLProtocol.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


import Foundation

class MockURLProtocol: URLProtocol {
    static var responseData: Data?
    static var responseStatusCode: Int = 200
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override func startLoading() {
        if let client = client {
            if let responseData = MockURLProtocol.responseData {
                let response = HTTPURLResponse(url: request.url!,
                                               statusCode: MockURLProtocol.responseStatusCode,
                                               httpVersion: nil,
                                               headerFields: nil)!
                client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                client.urlProtocol(self, didLoad: responseData)
            }
            client.urlProtocolDidFinishLoading(self)
        }
    }
}
