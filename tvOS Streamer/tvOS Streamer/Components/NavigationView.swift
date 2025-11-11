//
//  NavigationView.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-08.
//

import SwiftUI

struct NavigationView: View {
    var body: some View {
        TabView {
            FeaturedView()
            .tabItem {
                Label("Featured", systemImage: "house")
            }
            MoviesView()
            .tabItem {
                Label("Movies", systemImage: "television")
            }
            TVShowsView()
            .tabItem {
                Label("TV Shows", systemImage: "television")
            }
        }
    }
}

#Preview {
    NavigationView()
}
