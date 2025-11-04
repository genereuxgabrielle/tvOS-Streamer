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
            // Pass nil or your API URL here
            // Example: FeaturedView(apiURL: "https://your-api.com/content")
            FeaturedView()
        }
    }
}
