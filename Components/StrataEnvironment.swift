//
//  StrataCellEnvironment.swift
//  Strata
//
//  Created by José Luis Canepa on 17-09-25.
//

import SwiftUI

enum StrataCellContentRenderStyle {
    case plain, segue
    
    var displaysSegueIndicator: Bool {
        return self == .segue
    }
}

/// A `hint` applied to the contents of any vertically stacked object
///
/// The `hint` allows the view to set its background accordingly to their position in a vertical stack.
enum StrataStackedHint {
    case head, middle, tail, standalone
}

struct StrataCellMetrics {
    /// How rounded are the corners of the background
    let roundedness: CGFloat
    
    /// Horizontal padding of the contents of a cell
    let horizontalPadding: CGFloat
    
    init(roundedness: CGFloat = 4.0, horizontalPadding: CGFloat = 16.0) {
        self.roundedness = roundedness
        self.horizontalPadding = horizontalPadding
    }
    
    static var `default`: Self { Self() }
}

extension EnvironmentValues {
    /// Determines how to render the background of any vertically stacked element. Any vertical-stacking `Strata` component
    /// automatically provides these values
    @Entry var strataStackedHint: StrataStackedHint = .standalone
    
    /// Determines how to render the contents of a cell. The content is auto-inferred depending
    /// on the initialization of the cell, but can be overriden with this
    @Entry var strataCellContentRenderStyle: StrataCellContentRenderStyle? = nil
    
    /// Metrics of how to render the cell
    @Entry var strataCellMetrics: StrataCellMetrics = .default
    
    /// Which color to use for the background of a particular cell
    @Entry var strataCellBackgroundColor: Color = .white
    
    /// A view to use as a badge
    @Entry var strataBadge: Text? = nil
}

extension View {
    func strataBadge(_ text: String) -> some View {
        self.environment(\.strataBadge, Text(text))
    }
    
    func strataBadge(_ text: Int) -> some View {
        self.environment(\.strataBadge, Text(text.formatted()))
    }
    
    func strataCellStyle(_ render: StrataCellContentRenderStyle) -> some View {
        self.environment(\.strataCellContentRenderStyle, render)
    }
}
