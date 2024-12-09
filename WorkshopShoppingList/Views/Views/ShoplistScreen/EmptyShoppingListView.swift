//
//  EmptyShoppingListView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import SwiftUI
import Combine

struct EmptyShoppingListView: View {
    @Binding var showCreatingNewListSheet: Bool
    var body: some View {
        VStack{
            PlaceholderView(imageName: AppConstants.ImageNames.ShoppingListScreen,
                            mainMessage: AppConstants.Texts.shopListScreenEmptyListMainMessage,
                            subMessage: AppConstants.Texts.shopListScreenEmptyListSubMessage
            )
            Spacer()
            Button(action: {
                showCreatingNewListSheet.toggle()
            }){
                Spacer()
                Text(AppConstants.Texts.addListButtonText)
                    .font(AppConstants.Fonts.largeTextBody17)
                    .tracking(-0.43)
                    .tint(.textTetriary)
                    .padding(.vertical, 14)
                Spacer()
            }
            .background(.accentPrimary)
            .cornerRadius(14)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .animatedOnAppear()
    }
}

#Preview {
    EmptyShoppingListView(showCreatingNewListSheet: .constant(false))
}
