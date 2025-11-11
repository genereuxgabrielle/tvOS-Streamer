//
//  Content.swift
//  tvOS Streamer
//

import Foundation

struct Movie: Content {
    var id: Int
    var title: String
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var releaseDate: String?
    var voteAverage: Double?
    var popularity: Double?
    
    // Conform to Content protocol
    var displayTitle: String { title }
    
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
