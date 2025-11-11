//
//  FeaturedView.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-01.
//

import SwiftUI

struct MoviesView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 60) {
                    CarouselView<Movie>(apiURL: "https://api.themoviedb.org/3/movie/now_playing", title: "Now Playing")
                    CarouselView<Movie>(apiURL: "https://api.themoviedb.org/3/movie/popular", title: "Popular")
                    CarouselView<Movie>(apiURL: "https://api.themoviedb.org/3/movie/top_rated", title: "Top Rated")
                    CarouselView<Movie>(apiURL: "https://api.themoviedb.org/3/movie/upcoming", title: "Upcoming")
                }
                .padding(.top, 40)
            }
            .navigationTitle("Movies")
        }
    }
}

#Preview {
    MoviesView()
}
