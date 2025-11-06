//
//  ContentDetailsView.swift
//  tvOS Streamer
//
//  Created by Gabrielle Genereux on 2025-11-05.
//

import SwiftUI

struct ContentDetailsView: View {
    let content: Content
    var body: some View {
        Text(content.title)
    }
}

#Preview {
    ContentDetailsView(content: Content.sampleData[0] )
}
