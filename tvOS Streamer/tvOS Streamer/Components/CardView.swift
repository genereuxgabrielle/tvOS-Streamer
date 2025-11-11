//
//  CardView.swift
//  tvOS Streamer
//

import SwiftUI

struct CardView: View {
    let content: any Content
    
    var body: some View {
        ZStack {
            if let backdropPath = content.backdropPath,
               let imageURL = URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)") {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 400, height: 200)
                        .clipped()
                } placeholder: {
                    Color.gray.opacity(0.3)
                        .frame(width: 400, height: 200)
                }
            }
            
            LinearGradient(
                colors: [Color.clear, Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            
            VStack(alignment: .leading, spacing: 8) {
                Spacer()
                Text(content.displayTitle)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .accessibilityAddTraits(.isHeader)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding(20)
        }
        .frame(width: 400, height: 200)
        .cornerRadius(12)
        .clipped()
    }
}

#Preview {
    CardView(content: Movie(id: 1, title: "Sample Movie", overview: "A great movie"))
}
