//
//  StrataBadge.swift
//  Strata
//
//  Created by José Luis Canepa on 20-09-25.
//

import SwiftUI

struct StrataBadge: View {
    private let content: Text
    
    init(_ content: Text) {
        self.content = content
    }
    
    init<S: StringProtocol>(verbatim content: S) {
        self.content = Text(content)
    }
    
    init(_ titleKey: LocalizedStringKey) {
        self.content = Text(titleKey)
    }
    
    var body: some View {
        content
            .foregroundStyle(Color.white)
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
            .background(Color.red, in: .capsule)
    }
}
