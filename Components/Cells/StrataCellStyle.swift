//
//  StrataCellStyle.swift
//  Strata
//
//  Created by José Luis Canepa on 20-09-25.
//

import SwiftUI

/// A subset of button style, specifically for styling `StrataCell`.
protocol StrataCellStyle: ButtonStyle {}

struct StrataCellInformativeStyle: StrataCellStyle {
    init() {}
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

struct StrataCellRegularStyle: StrataCellStyle {
    init() {}
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}


struct StrataCellLinkStyle: StrataCellStyle {
    init() {}
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

extension StrataCellStyle where Self == StrataCellInformativeStyle {
    /// Informative style, does not display any changes based on user interaction
    static var informative: Self { Self() }
}
