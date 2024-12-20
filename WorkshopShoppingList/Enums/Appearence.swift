//
//  Appearence.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 10.12.2024.
//

import Foundation
import SwiftUI

enum Appearance: String, CaseIterable, Identifiable {

    case light
    case dark

    var id: String { self.rawValue }
    var colorScheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        }
    }
}
