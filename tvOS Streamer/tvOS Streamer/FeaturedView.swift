//
//  FeaturedView.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-01.
//

import SwiftUI

struct FeaturedView: View {
    var body: some View {
        NavigationStack {
            CarouselView(apiURL: "https://api.themoviedb.org/3/movie/popular", title: "Popular Movies")
            CarouselView(apiURL: "https://api.themoviedb.org/3/movie/top_rated", title: "Top Rated Movies")
                .navigationTitle("Featured")
        }
    }
}

#Preview {
    FeaturedView()
}
