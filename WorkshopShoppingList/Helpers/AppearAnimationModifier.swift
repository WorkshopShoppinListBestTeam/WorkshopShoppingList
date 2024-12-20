//
//  AppearAnimationModifier.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 06.12.2024.
//

import Foundation
import SwiftUI

struct AppearAnimationModifier: ViewModifier {
    @State private var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .scaleEffect(isVisible ? 1 : 0.9)
            .animation(.easeOut(duration: 0.4), value: isVisible)
            .onAppear {
                isVisible = true
        }
    }
}

extension View {
    func animatedOnAppear() -> some View {
        self.modifier(AppearAnimationModifier())
    }
}

