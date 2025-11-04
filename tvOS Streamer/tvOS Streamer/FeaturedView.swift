//
//  FeaturedView.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-01.
//

import SwiftUI
import ThemeKit

struct FeaturedView: View {
    @StateObject private var viewModel = ContentViewModel()
    let apiURL: String?
    
    init(apiURL: String? = nil) {
        self.apiURL = apiURL
    }
    
    var body: some View {
        NavigationStack {
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
                        LazyHStack(spacing: 20) {
                            ForEach(viewModel.content) { content in
                                CardView(content: content)
                                    .frame(width: 400, height: 200)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Featured")
            .task {
                await loadContent()
            }
        }
    }
    
    private func loadContent() async {
        if let apiURL = apiURL {
            await viewModel.fetchContent(from: apiURL)
        } else {
            // Fallback to sample data if no API URL provided
            viewModel.loadSampleData()
        }
    }
}

#Preview {
    FeaturedView()
}
