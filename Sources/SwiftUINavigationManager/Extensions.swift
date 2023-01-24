//
//  Extensions.swift
//  
//
//  Created by Kasper Munch on 24/01/2023.
//

import Foundation
import SwiftUI

public extension View {
    func makeNavigation<R: Hashable>(_ navigationManager: NavigationManager<R>) -> some View {
        modifier(navigationModifier<R>())
    }
}

private struct navigationModifier<R: Hashable>: ViewModifier {
    @EnvironmentObject private var navigationManager: NavigationManager<R>
    
    func body(content: Content) -> some View {
        NavigationStack(path: $navigationManager.path) {
            content
        }
    }
}
