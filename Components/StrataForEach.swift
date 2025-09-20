//
//  StrataList.swift
//  Strata
//
//  Created by José Luis Canepa on 17-09-25.
//

import SwiftUI

struct StrataForEach<Data: RandomAccessCollection, ID: Hashable, Content: View>: View {
    private let data: Data
    private let keyPath: KeyPath<Data.Element, ID>
    private let content: (_ item: Data.Element) -> Content
    private let indices: (first: ID, last: ID)?
    
    init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder content: @escaping (_: Data.Element) -> Content) {
        self.data = data
        self.keyPath = id
        self.content = content
        
        if let first = data.first?[keyPath: id], let last = data.last?[keyPath: id], first != last {
            self.indices = (first, last)
        }
        else {
            self.indices = nil
        }
    }
    
    init(_ data: Data, @ViewBuilder content: @escaping (_: Data.Element) -> Content) where Data.Element: Identifiable, ID == Data.Element.ID {
        self.init(data, id: \Data.Element.id, content: content)
    }
    
    private func cellRendererStyle(_ id: ID) -> StrataCellBackgroundRenderStyle {
        guard let indices else { return .standalone }
        
        if id == indices.first {
            return .head
        }
        else if id == indices.last {
            return .tail
        }
        
        return .middle
    }
    
    var body: some View {
        ForEach(data, id: keyPath, content: { (element: Data.Element) in
            content(element)
                .environment(\.strataCellBackgroundRenderStyle, cellRendererStyle(element[keyPath: keyPath]))
            if indices?.last != element[keyPath: keyPath] {
                Divider()
            }
        })
    }
}

#Preview {
    @Previewable @State var contents: [String] = ["a", "b", "c", "d"]
    
    LazyVStack(spacing: 0.0) {
        StrataForEach(contents, id: \.self) { (item: String) in
            VStack {
                Text(item)
            }
        }
    }
}

