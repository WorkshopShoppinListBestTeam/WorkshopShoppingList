//
//  WorkshopShoppingListApp.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 28.11.2024.
//

import SwiftUI

@main
struct WorkshopShoppingListApp: App {
    @AppStorage("appearance") private var appearance: Appearance = .light
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .preferredColorScheme(appearance.colorScheme)
        }
    }
}
