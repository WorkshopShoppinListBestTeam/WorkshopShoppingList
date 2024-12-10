//
//  ItemsListScreen.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 07.12.2024.
//

import SwiftUI
import Combine

struct ItemListScreen: View {
    @AppStorage(AppConstants.Texts.userOrderingUserDefaultsKey) private var userOrdering: Bool = false
    let shoppingList: ShoppingList
    @StateObject private var viewModel : ItemsScreenViewModel
    @State private var showCleanPurchasedAlert: Bool = false
    @State private var showDeleteAllAlert: Bool = false
    @State private var showAddNewItemSheet: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    init(shoppingList: ShoppingList) {
        self.shoppingList = shoppingList
        _viewModel = StateObject(wrappedValue: ItemsScreenViewModel(shoppingList: shoppingList))
    }
    var body: some View {
        ZStack{
            Color(.backgroundPrimary)
                .ignoresSafeArea()
            VStack{
                HStack{
                    Text(shoppingList.name ?? "Unamed list")
                        .frame(alignment: .leading)
                        .font(AppConstants.Fonts.header1)
                        .tint(.textPrimary)
                    Spacer()
                }
                .padding(.bottom, viewModel.items.isEmpty ? 55 : 26)
                .padding(.leading, 16)
                
                if viewModel.items.isEmpty{
                    EmptyItemsListView(showAddingNewItemsSheet: $showAddNewItemSheet)
                }
                else{
                    VStack{
                        ItemsListView(viewModel: viewModel)
                            .padding(.horizontal, 16)
                        Spacer()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button{
                        dismiss()
                    }label:{
                        HStack{
                            Image(systemName: "chevron.left")
                                .resizable()
                                .frame(width: 12, height: 20)
                                .padding(.vertical,12)
                            
                                .foregroundColor(.textSecondary)
                                .fontWeight(.bold)
                            
                            Text(AppConstants.Texts.backNavigationButtonText)
                                .padding(.vertical, 12)
                                .padding(.leading, 1)
                                .font(AppConstants.Fonts.largeTextBody17)
                                .foregroundColor(.textSecondary)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    topBarWithoutSearch
                }
            }
            .sheet(isPresented: $showAddNewItemSheet){
                NewItemtView(viewModel: viewModel, isViewPresented: $showAddNewItemSheet)
            }
            .ignoresSafeArea(.keyboard)
            .animatedOnAppear()
        }
        .onAppear(){
            if userOrdering == true{
                viewModel.purchasedOrderingItemsList()
            }
        }
        .alert(AppConstants.Texts.alertDeletingPurchasedTitle, isPresented: $showCleanPurchasedAlert) {
            Button(AppConstants.Texts.cancelText, role: .cancel) {}
            Button(AppConstants.Texts.deleteButtonText, role: .destructive) {
                viewModel.deleteAllBought()
            }
        } message: {
            Text(AppConstants.Texts.alertDeletingPurchasedMessage)
        }
        .alert(AppConstants.Texts.alertDeletingAllItemsTitle, isPresented: $showDeleteAllAlert) {
            Button(AppConstants.Texts.cancelText, role: .cancel) {}
            Button(AppConstants.Texts.deleteButtonText, role: .destructive) {
                viewModel.deleteAllItems()
            }
        } message: {
            Text(AppConstants.Texts.alertDeletingAllItemsMessage)
        }
    }
    
    private var topBarWithoutSearch: some View {
        HStack(spacing: 0) {
            Spacer()
            Button(action: {
                showAddNewItemSheet.toggle()
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
                        userOrdering = true
                        viewModel.purchasedOrderingItemsList()
                    }) {
                        HStack{
                            Label(AppConstants.Texts.orderByUser, image: AppConstants.ImageNames.Grabber)
                        }
                    }
                    
                    Button(action: {
                        userOrdering = false
                        viewModel.alphaOrderingItemsList()
                        
                    }) {
                        HStack{
                            Label(AppConstants.Texts.orderByAlphabet, systemImage: AppConstants.SymbolsName.orderingByAlphabet)
                        }
                    }
                } label: {
                    Label(AppConstants.Texts.orderMenuText, systemImage: AppConstants.SymbolsName.orderingByButton)
                }
                Button(action: {
                    showCleanPurchasedAlert.toggle()
                }) {
                    Label(AppConstants.Texts.deletePurchased, image: AppConstants.ImageNames.Clean)
                }
                
                Button(role: .destructive, action: {
                    showDeleteAllAlert.toggle()
                }) {
                    Label(AppConstants.Texts.deleteAllItems, systemImage: AppConstants.SymbolsName.trash)
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
}


#Preview {
    ItemListScreen(shoppingList: ShoppingList())
}
