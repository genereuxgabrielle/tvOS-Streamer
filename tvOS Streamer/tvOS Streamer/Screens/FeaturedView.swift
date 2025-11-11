//
//  FeaturedView.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-08.
//

import SwiftUI

struct FeaturedView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 60) {
                    CarouselView<Movie>(apiURL: "https://api.themoviedb.org/3/movie/popular", title: "Popular Movies")
                    CarouselView<TVShow>(apiURL: "https://api.themoviedb.org/3/tv/popular", title: "Popular TV Shows")
                    CarouselView<Movie>(apiURL: "https://api.themoviedb.org/3/movie/top_rated", title: "Top Rated Movies")
                    CarouselView<TVShow>(apiURL: "https://api.themoviedb.org/3/tv/top_rated", title: "Top Rated TV Shows")
                }
                .padding(.top, 40)
            }
            .navigationTitle("Featured")
        }
    }
}

#Preview {
    FeaturedView()
}
