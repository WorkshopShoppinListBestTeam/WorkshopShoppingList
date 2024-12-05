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
            PlaceholderView(imageName: "ShoppingListScreenLight",
                            mainMessage: AppConstants.Texts.shpoListScreenEmptyListMainMessage,
                            subMessage: AppConstants.Texts.shpoListScreenEmptyListSubMessage
            )
            Spacer()
            Button(action: {
                showCreatingNewListSheet.toggle()
            }){
                Spacer()
                Text("Добавить список")
                    .font(AppConstants.Fonts.largeTextBody17)
                    .tracking(-0.43)
                    .tint(.textTetriary)
                    .padding(.vertical, 14)
                Spacer()
            }
            .background(.accentPrimary)
            .cornerRadius(14)
            .padding(.horizontal, 16)
            Spacer()
        }
    }
}

#Preview {
    EmptyShoppingListView(showCreatingNewListSheet: .constant(false))
}
