//
//  CarouselView.swift
//  tvOS Streamer
//

import SwiftUI

struct CarouselView<T: Content>: View {
    @StateObject private var viewModel = ContentViewModel<T>()
    let apiURL: String?
    let title: String
    
    init(apiURL: String? = nil, title: String) {
        self.apiURL = apiURL
        self.title = title
    }
    @Namespace private var carouselNamespace
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.title2)
                .focusable(false)  // Title shouldn't be focusable
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
                            ForEach(Array(viewModel.content.enumerated()), id: \.element.id) { index, content in
                                NavigationLink(destination: ContentDetailsView(content: content)) {
                                    CardView(content: content)
                                        .frame(width: 400, height: 200)
                                }
                                .buttonStyle(.plain)
                                .prefersDefaultFocus(index == 0, in: carouselNamespace)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .focusSection()
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
        }
    }
}

#Preview {
    CarouselView<Movie>(title: "Featured")
}
