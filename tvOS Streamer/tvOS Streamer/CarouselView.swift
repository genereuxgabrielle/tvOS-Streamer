//
//  CarouselView.swift
//  tvOS Streamer
//

import SwiftUI

struct CarouselView: View {
    @StateObject private var viewModel = ContentViewModel()
    let apiURL: String?
    let title: String
    
    init(apiURL: String? = nil, title: String) {
        self.apiURL = apiURL
        self.title = title
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title2)            
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    VStack(spacing: 20) {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.system(size: 60))
                        Text(errorMessage)
                            .font(.headline)
                        Button("Retry") {
                            Task {
                                await loadContent()
                            }
                        }
                    }
                } else if viewModel.content.isEmpty {
                    Text("No content available")
                        .font(.headline)
                } else {
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 40) {
                            ForEach(viewModel.content) { content in
                                NavigationLink(destination: ContentDetailsView(content: content)) {
                                    CardView(content: content)
                                        .frame(width: 400, height: 200)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .scrollClipDisabled()
                    .frame(height: 220)
                }
            }
        }
        .task {
            await loadContent()
        }
    }
    private func loadContent() async {
        if let apiURL = apiURL {
            // Use custom fetch with auth
            let queryItems: [URLQueryItem] = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1"),
            ]
            
            let headers = [
                "accept": "application/json",
                "Authorization": APIConfig.tmdbAPIKey
            ]
            
            await viewModel.fetchContentWithAuth(baseURL: apiURL, queryItems: queryItems, headers: headers)
        } else {
            // Fallback to sample data if no API URL provided
            viewModel.loadSampleData()
        }
    }
}
#Preview {
    CarouselView(title: "Featured")
}
