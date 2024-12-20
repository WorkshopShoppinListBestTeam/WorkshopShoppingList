//
//  EmptyItemsListView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 08.12.2024.
//

import SwiftUI

struct EmptyItemsListView: View {
    @Binding var showAddingNewItemsSheet: Bool
    var body: some View {
        VStack{
            PlaceholderView(imageName: AppConstants.ImageNames.ProductListScreen,
                            mainMessage: AppConstants.Texts.itemScreenEmptyListMainMessage,
                            subMessage: AppConstants.Texts.itemScreenEmptyListSubMessage
            )
            Spacer()
        }
        .animatedOnAppear()
    }
}

#Preview {
    EmptyItemsListView(showAddingNewItemsSheet: .constant(false))
}
