//
//  ShoplistsScreen.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import SwiftUI
import Combine

struct ShoplistsScreen: View {
    @AppStorage(AppConstants.Texts.appearanceUserDefaultsKey) private var appearance: Appearance = .light
    @State private var showCreatingNewListSheet = false
    @State private var showSearchBar = false
    @State private var showDeleteAllAlert: Bool = false
    @State private var searchText = ""
    @FocusState private var isSearchBarFocused: Bool
    @StateObject private var viewModel =  ShoplistsScreenViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                Color(.backgroundPrimary)
                    .ignoresSafeArea()
                
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
                            .padding(.bottom, viewModel.shoppingLists.isEmpty ? 55 : 26)
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
            .alert(AppConstants.Texts.alertDeletingAllListsTitle, isPresented: $showDeleteAllAlert) {
                Button(AppConstants.Texts.cancelText, role: .cancel) {}
                Button(AppConstants.Texts.deleteButtonText, role: .destructive) {
                    viewModel.removeAll()
                }
            } message: {
                Text(AppConstants.Texts.alertDeletingAllListsMessage)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
            Menu{
                Menu{
                    Button(action: {
                        appearance = .light
                    }) {
                        HStack{
                            Label(AppConstants.Texts.lightThemeLabeltext, systemImage: AppConstants.SymbolsName.sunMax)
                        }
                    }
                    Button(action: {
                        appearance = .dark
                    }) {
                        HStack{
                            Label(AppConstants.Texts.darkThemeLabeltext, systemImage: AppConstants.SymbolsName.moon)
                        }
                    }
                } label: {
                    Label(AppConstants.Texts.themeLabelText, systemImage: AppConstants.SymbolsName.paintPalette)
                }
                
                Button(role: .destructive, action: {
                    showDeleteAllAlert.toggle()
                }) {
                    Label(AppConstants.Texts.deleteAll, systemImage: AppConstants.SymbolsName.trash)
                }
            } label: {
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
                        Image(systemName: AppConstants.SymbolsName.xmarkCircleFill)
                            .foregroundColor(.extraTintSecondary)
                    }
                    .padding(.trailing, 16)
                }
            }
            .background(.backgroundSecondary)
            .cornerRadius(10)
            .onChange(of: searchText){ newValue in
                viewModel.filteringShoppingLists(for: newValue)
            }
            Button(action: {
                searchText = ""
                viewModel.fetchLists()
                showSearchBar.toggle()
            }) {
                Text(AppConstants.Texts.cancelText)
                    .foregroundColor(.textSecondary)
            }
        }
        .padding(.horizontal, 16)
    }
}
#Preview {
    ShoplistsScreen()
}
