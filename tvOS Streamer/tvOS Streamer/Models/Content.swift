//
//  Content.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-02.
//

import Foundation

// Response wrapper that TMDB API returns
struct TMDBResponse: Codable {
    let page: Int
    let results: [Content]
    let totalPages: Int
    let totalResults: Int
}

struct Content: Identifiable, Codable {
    var id: Int
    var title: String
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String?
    var voteAverage: Double?
    var popularity: Double?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath
        case backdropPath
        case releaseDate
        case voteAverage
        case popularity
    }
    
    init(id: Int, title: String, overview: String)
    {
        self.id = id
        self.title = title
        self.overview = overview
        self.posterPath = nil
        self.backdropPath = nil
        self.releaseDate = nil
        self.voteAverage = nil
        self.popularity = nil
    }
}
