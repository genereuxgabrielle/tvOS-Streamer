//
//  tvOS_StreamerApp.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-10-29.
//

import SwiftUI

@main
struct tvOS_StreamerApp: App {
    var body: some Scene {
        WindowGroup {
            // Pass the Movie DB API URL to fetch popular movies
            FeaturedView()
            
            // Or use nil to load sample data for testing
            // FeaturedView()
        }
    }
}
