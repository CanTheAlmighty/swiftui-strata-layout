//
//  StrataHeaderCell.swift
//  Strata
//
//  Created by José Luis Canepa on 17-09-25.
//

import SwiftUI

struct StrataHeaderCell<ImageContent: View>: View {
    // Environment (Strata Cell)
    private let strataCellBackgroundRenderStyle: StrataCellBackgroundRenderStyle = .head
    @Environment(\.strataCellContentRenderStyle)    private var strataCellContentRenderStyle: StrataCellContentRenderStyle?
    @Environment(\.strataCellBackgroundColor)       private var strataCellBackgroundColor: Color
    @Environment(\.strataCellMetrics)               private var strataCellMetrics: StrataCellMetrics
    
    private let content: ImageContent
    
    init(_ name: String, bundle: Bundle? = nil) where ImageContent == Image {
        content = Image(name, bundle: bundle)
    }
    
    var body: some View {
        VStack {
            content
                .frame(height: 137.0)
                .clipShape(UnevenRoundedRectangle(topLeadingRadius: strataCellMetrics.roundedness, topTrailingRadius: strataCellMetrics.roundedness))
                .clipped()
        }
        .padding(.horizontal, 16.0)
    }
}

#Preview("Static") {
    ScrollView {
        LazyVStack(spacing: 0.0) {
            StrataHeaderCell("catto")
            Divider()
            StrataCell("How are youuu").environment(\.strataCellBackgroundRenderStyle, .middle)
            Divider()
            StrataCell("Segue!")
                .environment(\.strataCellBackgroundRenderStyle, .middle)
                .environment(\.strataCellContentRenderStyle, .segue)
            Divider()
            StrataCell("Goodbye").environment(\.strataCellBackgroundRenderStyle, .tail)
        }
        .padding(16.0)
    }
    .background(Color(white: 0.92))
}
