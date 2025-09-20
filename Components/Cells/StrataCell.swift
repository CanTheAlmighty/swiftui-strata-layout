//
//  StrataCell.swift
//  Strata
//
//  Created by José Luis Canepa on 17-09-25.
//

import SwiftUI

struct StrataCell<Content: View>: View {
    // Environment (Strata Cell)
    @Environment(\.strataCellBackgroundRenderStyle) private var strataCellBackgroundRenderStyle: StrataCellBackgroundRenderStyle
    @Environment(\.strataCellContentRenderStyle)    private var strataCellContentRenderStyle: StrataCellContentRenderStyle?
    @Environment(\.strataCellBackgroundColor)       private var strataCellBackgroundColor: Color
    @Environment(\.strataCellMetrics)               private var strataCellMetrics: StrataCellMetrics
    @Environment(\.strataBadge)                     private var strataBadge: Text?
    
    // Contents
    private let content: Content
    private let renderStyleInferred: StrataCellContentRenderStyle
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
        self.renderStyleInferred = .plain
    }
    
    init<S: StringProtocol>(_ text: S) where Content == Text {
        self.content = Text(text)
        self.renderStyleInferred = .plain
    }
    
    init<S: StringProtocol>(_ text: S, systemImage: String) where Content == Label<Text, Image> {
        self.content = Label(text, systemImage: systemImage)
        self.renderStyleInferred = .plain
    }
    
    init<S: StringProtocol>(_ titleKey: S, systemImage: String, action: @escaping () -> Void) where Content == Button<Label<Text, Image>> {
        self.content = Button(titleKey, systemImage: systemImage, action: action)
        self.renderStyleInferred = .plain
    }
    
    init<S: StringProtocol, Destination: Hashable>(_ titleKey: S, value: Destination) where Content == NavigationLink<Text, Never> {
        self.content = NavigationLink(titleKey, value: value)
        self.renderStyleInferred = .segue
    }
    
    init<S: StringProtocol, Destination: View>(_ titleKey: S, destination: Destination) where Content == NavigationLink<Text, Destination> {
        self.content = NavigationLink(titleKey, destination: destination)
        self.renderStyleInferred = .segue
    }
    
    private var renderStyle: StrataCellContentRenderStyle {
        strataCellContentRenderStyle ?? renderStyleInferred
    }
    
    @ViewBuilder private var background: some View {
        switch strataCellBackgroundRenderStyle {
        case .head:
            UnevenRoundedRectangle(topLeadingRadius: strataCellMetrics.roundedness, topTrailingRadius: strataCellMetrics.roundedness)
                .fill(strataCellBackgroundColor)
        case .middle:
            Rectangle()
                .fill(strataCellBackgroundColor)
        case .tail:
            UnevenRoundedRectangle(bottomLeadingRadius: strataCellMetrics.roundedness, bottomTrailingRadius: strataCellMetrics.roundedness)
                .fill(strataCellBackgroundColor)
        case .standalone:
            RoundedRectangle(cornerRadius: strataCellMetrics.horizontalPadding)
                .fill(strataCellBackgroundColor)
        }
    }
    
    var body: some View {
        Button(action: {}, label: {
            ZStack {
                background
                HStack(alignment: .center) {
                    content.layoutPriority(2.0)
                    if strataBadge != nil || renderStyle.displaysSegueIndicator == true {
                        Spacer()
                    }
                    if let strataBadge {
                        StrataBadge(strataBadge)
                    }
                    if renderStyle.displaysSegueIndicator {
                        Image(systemName: "chevron.right")
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 34.0, alignment: .leading)
                .padding(.vertical, 4.0)
                .padding(.horizontal, strataCellMetrics.horizontalPadding)
            }
        })
        .buttonStyle(.plain)
    }
}

#Preview("Static") {
    ScrollView {
        LazyVStack(spacing: 0.0) {
            StrataCell("Hello world!")
                .environment(\.strataCellBackgroundRenderStyle, .head)
                .strataCellStyle(.plain)
            Divider()
            StrataCell("How are youuu")
                .environment(\.strataCellBackgroundRenderStyle, .middle)
                .strataCellStyle(.plain)
                .strataBadge("Hello")
            Divider()
            StrataCell("Segue!")
                .environment(\.strataCellBackgroundRenderStyle, .middle)
                .strataCellStyle(.segue)
                .strataBadge("Hello")
            Divider()
            StrataCell("Goodbye")
                .environment(\.strataCellBackgroundRenderStyle, .tail)
                .strataCellStyle(.plain)
        }
        .padding(16.0)
    }
    .background(Color(white: 0.92))
}

#Preview("Dynamic") {
    @Previewable @State var contents: [String] = ["a", "b", "c", "d"]
    
    ScrollView {
        LazyVStack(spacing: 0.0) {
            StrataForEach(contents, id: \.self) { (item: String) in
                StrataCell {
                    Text("Letter \(item.uppercased())")
                }
            }
        }
        .padding(16.0)
    }
    .background(Color(white: 0.92))
}
