//
//  TVShows.swift
//  tvOS Streamer
//

import SwiftUI

struct TVShowsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 60) {
                    CarouselView<TVShow>(apiURL: "https://api.themoviedb.org/3/tv/airing_today", title: "Airing Today")
                    CarouselView<TVShow>(apiURL: "https://api.themoviedb.org/3/tv/popular", title: "Popular")
                    CarouselView<TVShow>(apiURL: "https://api.themoviedb.org/3/tv/top_rated", title: "Top Rated")
                    CarouselView<TVShow>(apiURL: "https://api.themoviedb.org/3/tv/on_the_air", title: "On The Air")
                }
                .padding(.top, 40)
            }
            .navigationTitle("TV Shows")
        }
    }
}

#Preview {
    TVShowsView()
}
