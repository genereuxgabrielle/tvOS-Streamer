//
//  Content.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-02.
//

import Foundation
import ThemeKit

struct Content: Identifiable, Codable {
    var title: String
    var duration: Int
    var id: UUID
    var theme: Theme
    
    // CodingKeys to exclude theme from API decoding
    enum CodingKeys: String, CodingKey {
        case title
        case duration
        case id
    }
    
    init(id: UUID = UUID(), title: String, duration: Int, theme: Theme)
    {
        self.id = id
        self.title = title
        self.duration = duration
        self.theme = theme
    }
    
    // Custom decoder that assigns a theme after decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        duration = try container.decode(Int.self, forKey: .duration)
        id = try container.decode(UUID.self, forKey: .id)
        
        // Assign a random theme from available themes
        theme = Theme.allCases.randomElement() ?? .oxblood
    }
}
