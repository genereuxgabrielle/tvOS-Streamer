//
//  ContentDetailsView.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-05.
//

import SwiftUI

struct ContentDetailsView<T: Content>: View {
    let content: T
    @StateObject private var viewModel = ContentViewModel<T>()
    @Environment(\.dismiss) private var dismiss
    
    var contentType: String {
        if T.self == Movie.self {
            return "movie"
        } else if T.self == TVShow.self {
            return "tv"
        }
        return "movie" // fallback
    }
    
    var body: some View {
        ZStack {
            // Background image - full screen
            if let backdropPath = content.backdropPath,
               let imageURL = URL(string: "https://image.tmdb.org/t/p/w1280\(backdropPath)") {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .ignoresSafeArea()
                }
            } else {
                // Fallback when no image
                Color.gray.opacity(0.3)
                    .ignoresSafeArea()
            }
            LinearGradient(
                colors: [Color.clear, Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .font(.headline)
                    .padding()
                }
                .buttonStyle(.plain)

                Spacer().frame(height: 50)    

                if viewModel.isLoading {
                ProgressView("Loading details...")
                } else if let errorMessage = viewModel.errorMessage {
                VStack(spacing: 20) {
                    Image(systemName: "exclamationmark.triangle")
                        .font(.system(size: 60))
                    Text(errorMessage)
                        .font(.headline)
                    Button("Retry") {
                        Task {
                            await loadDetails()
                        }
                    }
                }
                } else if let detailedContent = viewModel.content.first {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(detailedContent.displayTitle)
                        .font(.largeTitle)
                        .bold()
                        Text(detailedContent.overview ?? "No description available")
                        .font(.body)
                    // Add more details here (release date, rating, etc.)
                    }
                    .padding()
                } else {
                    Text("No details available")
                }
            }
            .task {
                await loadDetails()
            }
        }
        .navigationBarBackButtonHidden(false)
    }
    
    private func loadDetails() async {
        let detailURL = "\(APIConfig.tmdbBaseURL)/\(contentType)/\(content.id)"
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
        ]
        
        let headers = [
            "accept": "application/json",
            "Authorization": APIConfig.tmdbAPIKey
        ]
        
        await viewModel.fetchContentDetailsWithAuth(baseURL: detailURL, queryItems: queryItems, headers: headers)
    }
}

#Preview {
    ContentDetailsView(content: Movie(id: 1, title: "Sample Movie", overview: "A great movie"))
}
