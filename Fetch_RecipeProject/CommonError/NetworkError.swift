//
//  NetworkError.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


// MARK: - Error Handling
enum NetworkError: Error {
    case invalidURL
    case decodingError(String)
    case invalidImageData
    case networkFailure(String)
    case requestFailed(Int, String)  
    case unexpectedError(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid. Please check the API endpoint."
        case .decodingError(let message):
            return "Failed to decode response: \(message)"
        case .invalidImageData:
            return "The image data is invalid. Unable to load image."
        case .networkFailure(let message):
            return "Network request failed: \(message)"
        case .requestFailed(let statusCode, let message):
            return "Request failed with status code \(statusCode): \(message)"
        case .unexpectedError(let message):
            return "An unexpected error occurred: \(message)"
        }
    }
}

