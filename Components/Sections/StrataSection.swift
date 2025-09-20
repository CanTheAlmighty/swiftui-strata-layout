//
//  StrataSection.swift
//  Strata
//
//  Created by José Luis Canepa on 20-09-25.
//

import SwiftUI

struct StrataSection<Content: View, Header: View, Footer: View>: View {
    private let content: Content
    private let header: Header
    private let footer: Footer
    
    init(@ViewBuilder _ content: () -> Content) where Header == EmptyView, Footer == EmptyView {
        self.content = content()
        self.header = EmptyView()
        self.footer = EmptyView()
    }
    
    init(@ViewBuilder _ content: () -> Content, @ViewBuilder header: () -> Header) where Footer == EmptyView {
        self.content = content()
        self.header = header()
        self.footer = EmptyView()
    }
    
    init(@ViewBuilder _ content: () -> Content, @ViewBuilder footer: () -> Footer) where Header == EmptyView {
        self.content = content()
        self.header = EmptyView()
        self.footer = footer()
    }
    
    init(@ViewBuilder _ content: () -> Content, @ViewBuilder header: () -> Header, @ViewBuilder footer: () -> Footer) {
        self.content = content()
        self.header = header()
        self.footer = footer()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            header
                .padding(.horizontal, 24.0)
            VStack(spacing: 0.0) {
                content
            }.padding(16.0)
            footer
                .padding(.horizontal, 24.0)
        }
    }
}

// MARK: - Text extensions

extension StrataSection {
    init<HS: StringProtocol>(header: HS, @ViewBuilder _ content: () -> Content) where Header == Text, Footer == EmptyView {
        self.content = content()
        self.header = Text(header)
        self.footer = EmptyView()
    }
    
    init<HS: StringProtocol, FS: StringProtocol>(header: HS, footer: FS, @ViewBuilder _ content: () -> Content) where Header == Text, Footer == Text {
        self.content = content()
        self.header = Text(header)
        self.footer = Text(footer)
    }
}

#Preview {
    StrataList {
        StrataSection(header: "Como estas") {
            StrataCell("Hello World").environment(\.strataCellBackgroundRenderStyle, .head)
            Divider()
            StrataCell("Hello World").environment(\.strataCellBackgroundRenderStyle, .tail)
        }
    }
}
