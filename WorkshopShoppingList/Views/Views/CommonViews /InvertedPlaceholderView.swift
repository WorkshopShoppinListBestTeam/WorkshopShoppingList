//
//  InvertedEmptyShoppingListView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 06.12.2024.
//

import SwiftUI

struct InvertedPlaceholderView: View {
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
            Text(mainMessage)
                .font(AppConstants.Fonts.header2)
                .lineSpacing(5)
                .tracking(-0.45)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, 16)
                .frame(alignment: .center)
                .padding(.top, 16)
            
            Text(subMessage)
                .font(AppConstants.Fonts.largeTextBody17)
                .lineSpacing(-5)
                .tracking(-0.43)
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)
                .padding(.top,12)
                
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal,26)
                .padding(.top,24)
        
            Spacer()
        }
        .animatedOnAppear()
    }
}

#Preview {
    InvertedPlaceholderView(imageName: "NoResultsFoundScreenLight",
                    mainMessage:  "Добро пожаловать!",
                    subMessage:"Life is good")
}
