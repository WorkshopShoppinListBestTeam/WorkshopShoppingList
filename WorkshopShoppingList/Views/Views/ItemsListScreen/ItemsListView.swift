//
//  ItemsListView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 08.12.2024.
//

import SwiftUI

struct ItemsListView: View {
    @ObservedObject var viewModel: ItemsScreenViewModel
    @State private var showEditItemSheet = false
    @State private var selectedItemName: String?
    @State private var selectedItem :  Item?


    var body: some View {
        List{
            ForEach(viewModel.items, id: \.self) { item in
                let name = item.name ?? AppConstants.Texts.unamedText
                let quantity = Int(item.quantity)
                let measurement = item.unit ?? MeasurementUnit.pieces.rawValue
                HStack {
                    Button(action: {
                        viewModel.togglePurchased(for: item)
                        viewModel.purchasedOrderingItemsList()
                    }) {
                        Image(systemName: item.isPurchased ? AppConstants.SymbolsName.checkmarkCircleFill : AppConstants.SymbolsName.circle)
                            .foregroundColor(item.isPurchased ? .accentSecondary : .textSecondary)
                            .padding(.trailing, 10)
                    }
                    .contentShape(Rectangle())
                    
                    Text(name)
                        .font(.headline)
                        .strikethrough(item.isPurchased)
                        .foregroundColor(.textPrimary)
                        .padding(.leading, 10)
                        .lineLimit(2)
                        .truncationMode(.tail)
                                    
                    Spacer()
                    
                    if(quantity != 0){
                        Text("\(quantity) \(measurement)")
                        
                    }
                }
                .padding()
                .background(Color.backgroundPrimary)
                .cornerRadius(10)
                .contextMenu {
                    Button(action: {
                        selectedItemName = name
                        showEditItemSheet.toggle()
                    }) {
                        Label(AppConstants.Texts.editButtonText, systemImage: AppConstants.SymbolsName.pencil)
                    }
                    
                    Button(action: {
                        viewModel.deleteItem(item)
                        
                    }) {
                        Label(AppConstants.Texts.deleteButtonText, systemImage: AppConstants.SymbolsName.trash)
                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive, action: {
                        viewModel.deleteItem(item)
                    }) {
                        Label(AppConstants.Texts.deleteButtonText, systemImage: AppConstants.SymbolsName.trash)
                    }
                    
                    Button(action: {
                        selectedItemName = name
                        showEditItemSheet.toggle()
                    }) {
                        Label(AppConstants.Texts.editButtonText, systemImage: AppConstants.SymbolsName.pencil)
                    }
                    .tint(.extraTintSecondary)
                }
                
            }
            .onMove { indices, newOffset in
                var items = viewModel.items
                items.move(fromOffsets: indices, toOffset: newOffset)
            }
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.visible)
            
        }
        .listRowSpacing(8)
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .sheet(isPresented: $showEditItemSheet){
            EditItemView(viewModel: viewModel, isViewPresented: $showEditItemSheet, currentItemName: $selectedItemName)
        }
    
    }
}

#Preview {
    ItemsListView(viewModel: ItemsScreenViewModel(shoppingList: ShoppingList()))
}
