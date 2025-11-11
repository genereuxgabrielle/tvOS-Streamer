//
//  Content.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-08.
//

import Foundation

// Protocol that both Movie and TVShow conform to
protocol Content: Identifiable, Codable {
    var id: Int { get }
    var displayTitle: String { get } 
    var overview: String? { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
    var voteAverage: Double? { get }
    var popularity: Double? { get }
}

// Response wrapper that TMDB API returns
struct TMDBResponse<T: Codable>: Codable {
    let page: Int
    let results: [T]
    let totalPages: Int
    let totalResults: Int
}
