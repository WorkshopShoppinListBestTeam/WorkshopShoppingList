//
//  ShoplistsScreen.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import SwiftUI
import Combine

struct ShoplistsScreen: View {
    @State private var showCreatingNewListSheet = false
    @State private var showSearchBar = false
    @State private var searchText = ""
    @FocusState private var isSearchBarFocused: Bool
    @StateObject private var viewModel =  ShoplistsScreenViewModel()
    var body: some View {
        VStack{
            ZStack {
                if showSearchBar {
                    searchBar
                        .opacity(showSearchBar ? 1 : 0)
                        .onAppear(){
                            isSearchBarFocused = true
                        }
                    
                } else {
                    topBarWithSearch
                        .opacity(showSearchBar ? 0 : 1)
                }
            }
            .frame(height: 44)
            .animation(.easeInOut, value: showSearchBar)
            
            if !showSearchBar{
                VStack{
                    HStack{
                        Text(AppConstants.Texts.shpoListScreenTitle)
                            .frame(alignment: .leading)
                            .font(AppConstants.Fonts.header1)
                            .tint(.textPrimary)
                        Spacer()
                    }
                    .padding(.bottom, 55)
                    .padding(.leading, 16)
                    .animation(.easeInOut(duration: 0.2), value: showSearchBar)
                }
            }else{
                if(showSearchBar && !searchText.isEmpty && viewModel.shoppingLists.isEmpty){
                    VStack{
                        InvertedPlaceholderView(imageName: AppConstants.ImageNames.NoResultsFound,
                                                mainMessage: AppConstants.Texts.noResultFoundMainText,
                                                subMessage: AppConstants.Texts.noResultFoundSubText
                        )
                        Spacer()
                    }
                }
            }
        
        if viewModel.shoppingLists.isEmpty{
            if !(showSearchBar && !searchText.isEmpty){
                EmptyShoppingListView(showCreatingNewListSheet: $showCreatingNewListSheet)
                    .padding(.top, showSearchBar ? 108 : 0)
            }
        }
        else{
            ShoppinglistsListView(viewModel: viewModel)
        }
    }
        .sheet(isPresented: $showCreatingNewListSheet){
            NewShoppinglistView(viewModel: viewModel, isViewPresented: $showCreatingNewListSheet)
        }
        .ignoresSafeArea(.keyboard)
        .animatedOnAppear()
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
    HStack {
        HStack{
            Image(systemName: AppConstants.SymbolsName.magnifyingGlassSymbol)
                .foregroundColor(.textSecondary)
                .padding(.horizontal, 8)
            
            TextField("", text: $searchText)
                .modifier(TextFieldPlaceHolderTextModifier(placeholder: AppConstants.Texts.searchTextPlaceholder,
                                                           text: $searchText,
                                                           placeholderTextColor: .textSecondary, horizontalPadding: 0)
                )
                .focused($isSearchBarFocused)
                .padding(.vertical, 8)
                .background(.backgroundSecondary)
                .cornerRadius(8)
                .padding(.trailing, 16)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .background(.backgroundSecondary)
        .cornerRadius(10)
        
        
        Button(action: {
            searchText = ""
            showSearchBar.toggle()
        }) {
            Text(AppConstants.Texts.cancelSearchText)
                .foregroundColor(.textSecondary)
        }
    }
    .padding(.horizontal, 16)
    
}
}
#Preview {
    ShoplistsScreen()
}
