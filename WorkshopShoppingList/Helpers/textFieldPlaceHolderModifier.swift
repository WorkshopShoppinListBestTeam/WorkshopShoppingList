//
//  textFieldPlaceHolderModifier.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 06.12.2024.
//

import Foundation
import SwiftUI

struct TextFieldPlaceHolderTextModifier: ViewModifier {
    var placeholder: String
    var text: Binding<String>
    var placeholderTextColor: Color
    var horizontalPadding: CGFloat
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text(placeholder)
                    .font(AppConstants.Fonts.largeTextBody17)
                    .foregroundColor(placeholderTextColor)
            }
            content
        }
        .padding(.horizontal, horizontalPadding)
    }
}
