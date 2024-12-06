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
    @State private var showSearchBar: Bool = false
    @StateObject private var viewModel =  ShoplistsScreenViewModel()
    var body: some View {
        VStack{
            if showSearchBar{
                searchBar
            }else {
                topBarWithSearch
            }
            
            
            HStack{
                Text(AppConstants.Texts.shpoListScreenTitle)
                    .frame(alignment: .leading)
                    .font(AppConstants.Fonts.header1)
                    .tint(.textPrimary)
                Spacer()
            }
            .padding(.bottom, 55)
            .padding(.leading, 16)
            
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
    
    
   private var topBarWithSearch: some View {
        HStack(spacing: 0) {
            Spacer()
            Button(action: {
                showSearchBar.toggle()
            }) {
                Image(systemName: AppConstants.SymbolsName.magnifyingGlassSymbol)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(12)
            }
            .tint(.textSecondary)
            
            Button(action: {
                showCreatingNewListSheet.toggle()
            }) {
                Image(systemName: AppConstants.SymbolsName.plusSymbol)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(12)
            }
            .tint(.textSecondary)
            
            Button(action: {
                            print("Magnifying Glass tapped")
            }) {
                Image(systemName: AppConstants.SymbolsName.settingsSymbol)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(12)
            }
            .tint(.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var searchBar: some View {
        Text("Hello, World!")
            .onTapGesture {
                showSearchBar.toggle()
            }
    }
}
#Preview {
    ShoplistsScreen()
}
