//
//  NetworkManager.swift
//  Fetch_RecipeProject
//
//  Created by Muralidhar reddy Kakanuru on 2/8/25.
//


import Foundation
import UIKit

protocol RecipeApiInterface {
    func fetchRecipes(url: String)async throws -> [RecipeCusine]
    func fetchImages(url: String)async throws -> UIImage
}

class RecipeApiService: RecipeApiInterface {
    static let shared = RecipeApiService()
    private let session: URLSession
    private var imageCache = NSCache<NSString, UIImage>()
    
    init(session: URLSession = URLSession.shared) {
            self.session = session
        }
    
    // MARK: - Fetching Recipes data
    func fetchRecipes(url: String) async throws -> [RecipeCusine] {
        guard let serverURL = URL(string: url) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await session.data(from: serverURL)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.requestFailed(0, "Invalid response from server.")
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed(httpResponse.statusCode, "Unexpected response from server.")
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("✅ Raw JSON Response: \(jsonString)")
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                
                if decodedResponse.recipes.isEmpty {
                    print("Warning: No recipes available.")
                    return []
                }
                
                return decodedResponse.recipes
            } catch {
                print("Decoding Failed: \(error.localizedDescription)")
                print("Discarding malformed data and returning an empty list.")
                return []
            }
        } catch let urlError as URLError {
            throw NetworkError.networkFailure("Network request failed: \(urlError.localizedDescription)")
        } catch {
            throw NetworkError.unexpectedError(error.localizedDescription)
        }
    }
    
    
    // MARK: - Fetching Recipes images
    func fetchImages(url: String) async throws -> UIImage {
        if let cachedImage = imageCache.object(forKey: url as NSString) {
            return cachedImage
        }
        
        if let diskImage = loadImageFromDisk(url: url) {
            print("✅ Loaded from Disk Cache: \(url)")
            imageCache.setObject(diskImage, forKey: url as NSString)
            return diskImage
        }
        guard let serverURL = URL(string: url) else { throw NetworkError.invalidURL}
        
        do{
            let(data, response) = try await session.data(from: serverURL)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.requestFailed(0, "Invalid response from server.")
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed(httpResponse.statusCode, "Unexpected response from server.")
            }
            
            guard let image = UIImage(data: data) else { throw NetworkError.invalidImageData }
            imageCache.setObject(image, forKey: url as NSString)
            saveImageToDisk(image: image, url: url)
            
            return image
        }
        catch let urlError as URLError {
            throw NetworkError.networkFailure(urlError.localizedDescription)
        } catch {
            throw NetworkError.unexpectedError(error.localizedDescription)
        }
    }
    
    
    private func saveImageToDisk(image: UIImage, url: String) {
        guard let data = image.pngData() else { return }
        let filePath = getFilePath(for: url)
        do {
            try data.write(to: filePath)
            print("Image Saved to Disk: \(filePath)")
        } catch {
            print("Failed to Save Image: \(error.localizedDescription)")
        }
    }
    
    private func loadImageFromDisk(url: String) -> UIImage? {
        let filePath = getFilePath(for: url)
        if let data = try? Data(contentsOf: filePath), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    private func getFilePath(for url: String) -> URL {
        let fileManager = FileManager.default
        let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let filename = url.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? "cached_image"
        return cacheDirectory.appendingPathComponent(filename)
    }
}
