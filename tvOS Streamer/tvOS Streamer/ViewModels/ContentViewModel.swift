//
//  ContentViewModel.swift
//  tvOS Streamer
//

import Foundation
import Combine

@MainActor
class ContentViewModel<T: Content>: ObservableObject {
    @Published var content: [T] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    
    func fetchContentWithAuth(baseURL: String, queryItems: [URLQueryItem], headers: [String: String]) async {
        isLoading = true
        errorMessage = nil
        
        do {
            guard let url = URL(string: baseURL) else {
                errorMessage = "Invalid URL"
                isLoading = false
                return
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = headers
            
            // Fetch TMDB response
            let tmdbResponse: TMDBResponse<T> = try await networkService.fetch(with: request)
            content = tmdbResponse.results
        } catch let error as NetworkError {
            switch error {
            case .invalidURL:
                errorMessage = "Invalid URL"
            case .noData:
                errorMessage = "No data received"
            case .decodingError:
                errorMessage = "Failed to decode data"
            case .serverError(let statusCode):
                errorMessage = "Server error: \(statusCode)"
            }
        } catch {
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    // Fetch single Content item (for detail views)
    func fetchContentDetailsWithAuth(baseURL: String, queryItems: [URLQueryItem], headers: [String: String]) async {
        isLoading = true
        errorMessage = nil
        
        do {
            guard let url = URL(string: baseURL) else {
                errorMessage = "Invalid URL"
                isLoading = false
                return
            }
            
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems
            
            var request = URLRequest(url: components.url!)
            request.httpMethod = "GET"
            request.timeoutInterval = 10
            request.allHTTPHeaderFields = headers
            
            // Fetch single Content item (not wrapped in TMDBResponse)
            let fetchedContent: T = try await networkService.fetch(with: request)
            content = [fetchedContent]  // Wrap in array for consistency
        } catch let error as NetworkError {
            switch error {
            case .invalidURL:
                errorMessage = "Invalid URL"
            case .noData:
                errorMessage = "No data received"
            case .decodingError:
                errorMessage = "Failed to decode data"
            case .serverError(let statusCode):
                errorMessage = "Server error: \(statusCode)"
            }
        } catch {
            errorMessage = "An unexpected error occurred: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}

// Type aliases for convenience
typealias MovieViewModel = ContentViewModel<Movie>
typealias TVShowViewModel = ContentViewModel<TVShow>





