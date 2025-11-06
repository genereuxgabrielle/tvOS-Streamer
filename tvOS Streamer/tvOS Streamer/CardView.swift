//
//  CardView.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-02.
//

import SwiftUI

struct CardView: View {
    let content: Content
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Text(content.title)
                .font(.headline)
                .lineLimit(2)
                .accessibilityAddTraits(.isHeader)
            Text(content.overview ?? "No description available")
                .font(.caption)
                .lineLimit(2)
                .foregroundColor(.secondary)
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    List(Content.sampleData) { content in
        CardView(content: content)
    }
}
