//
//  PlaceholderView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 05.12.2024.
//

import SwiftUI

struct PlaceholderView: View {
    private let imageName: String
    private let mainMessage: String
    private let subMessage: String
    
    init(imageName: String, mainMessage: String, subMessage: String) {
        self.imageName = imageName
        self.mainMessage = mainMessage
        self.subMessage = subMessage
    }
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal,26)
                .padding(.bottom,32)
            
            Text(mainMessage)
                .font(AppConstants.Fonts.header2)
                .lineSpacing(5)
                .tracking(-0.45)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, 16)
                .frame(alignment: .center)
                .padding(.bottom, 12)
            
            Text(subMessage)
                .font(AppConstants.Fonts.largeTextBody17)
                .lineSpacing(-5)
                .tracking(-0.43)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                
            
            Spacer()
        }
    }
}

#Preview {
    PlaceholderView(imageName: "StartScreenLight",
                    mainMessage:  "Добро пожаловать!",
                    subMessage:"Life is good")
}
