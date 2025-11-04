//
//  CardView.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-02.
//

import SwiftUI
import ThemeKit

struct CardView: View {
    let content: Content
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(content.title)
                    .font(.subheadline)
                    .lineLimit(1)
                    .accessibilityAddTraits(.isHeader)
                Spacer()
                Label("\(content.duration)", systemImage: "clock")
                    .font(.caption)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(content.theme.mainColor)
        .foregroundColor(content.theme.accentColor)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    List(Content.sampleData) { content in
        CardView(content: content)
    }
}
