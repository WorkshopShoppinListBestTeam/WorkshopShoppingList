//
//  ItemsListScreen.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 07.12.2024.
//

import SwiftUI
import Combine

struct ItemListScreen: View {
    let shoppingList: ShoppingList
      @StateObject private var viewModel: ItemsScreenViewModel
      @State var showAddNewItemSheet: Bool = false
    @Environment(\.dismiss) private var dismiss
      
      init(shoppingList: ShoppingList) {
          self.shoppingList = shoppingList
          _viewModel = StateObject(wrappedValue: ItemsScreenViewModel(shoppingList: shoppingList))
      }
    var body: some View {
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
}


#Preview {
    ItemListScreen(shoppingList: ShoppingList())
}
