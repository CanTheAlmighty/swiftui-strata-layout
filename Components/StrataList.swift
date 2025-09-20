//
//  StrataList.swift
//  Strata
//
//  Created by José Luis Canepa on 17-09-25.
//

import SwiftUI

struct StrataList<Content: View>: View {
    private let content: Content
    
    init (@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ScrollView {
            content
        }
        .background(Color(white: 0.85))
    }
}
