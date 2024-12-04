//
//  ShoplistsScreen.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import SwiftUI
import Combine

struct ShoplistsScreen: View {
    @State private var showCreatingNewListSheet: Bool = false
    @StateObject private var viewModel =  ShoplistsScreenViewModel()
    var body: some View {
        Group{
            if viewModel.shoppingLists.isEmpty{
                EmptyShoppingListView(showCreatingNewListSheet: $showCreatingNewListSheet)
            }
            else{
                ShoppinglistsListView(viewModel: viewModel)
            }
        }

        
        .sheet(isPresented: $showCreatingNewListSheet){
            NewShoppinglistView()
        }
    }
}
#Preview {
    ShoplistsScreen()
}
