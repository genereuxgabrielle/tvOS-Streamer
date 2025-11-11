//
//  TVShow.swift
//  tvOS Streamer
//

import Foundation

struct TVShow: Content {
    var id: Int
    var name: String
    var overview: String?
    var posterPath: String?
    var backdropPath: String?
    var firstAirDate: String?  // TV shows use firstAirDate, not releaseDate
    var voteAverage: Double?
    var popularity: Double?
    
    // Conform to Content protocol
    var displayTitle: String { name }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case posterPath
        case backdropPath
        case firstAirDate
        case voteAverage
        case popularity
    }
    
    init(id: Int, name: String, overview: String)
    {
        self.id = id
        self.name = name
        self.overview = overview
        self.posterPath = nil
        self.backdropPath = nil
        self.firstAirDate = nil
        self.voteAverage = nil
        self.popularity = nil
    }
}
