//
//  ContentViewModel.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-04.
//

import Foundation

@MainActor
class ContentViewModel: ObservableObject {
    @Published var content: [Content] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let networkService = NetworkService.shared
    
    func fetchContent(from urlString: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedContent: [Content] = try await networkService.fetch(from: urlString)
            content = fetchedContent
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
    
    // For testing/preview purposes
    func loadSampleData() {
        content = Content.sampleData
    }
}

