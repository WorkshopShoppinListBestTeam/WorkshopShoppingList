//
//  ShoppinglistsListView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import SwiftUI
import Combine

struct ShoppinglistsListView: View {
    @ObservedObject var viewModel: ShoplistsScreenViewModel
    @State private var showSheet = false
    @State private var showEditShoppinlistSheet = false
    @State private var selectedItem: String?
    @State private var selectedListName: String?
    @State private var selectedEmojis: [String: String] = [:]
 
    
    let emojis = ["list.bullet.clipboard", "gift", "dumbbell", "paintpalette", "house", "graduationcap", "cross.case", "tshirt", "pawprint", "cart", "book", "party.popper", "wrench.and.screwdriver", "suitcase.rolling", "paperclip", "carrot", "teddybear", "heart", "fork.knife.circle", "briefcase", "exclamationmark.3", "stroller", "wineglass", "handbag", "cat", "camera", "car", "apps.ipad", "star", "eyebrow"]
    
    var body: some View {
    
        List{
            ForEach(viewModel.shoppingLists, id: \.name) { list in
                let name = list.name ?? "Unnamed"
                
                HStack(spacing: 8){
                        Button{
                            if !showSheet {
                                selectedItem = name
                                showSheet = true
                            }
                        } label: {
                            Image(systemName: selectedEmojis[name] ?? "list.bullet.clipboard")
                                .frame(width: 44,height: 44)
                                .foregroundColor(.textTetriary)
                                .background(.accentPrimary)
                                .cornerRadius(22)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                   
                        NavigationLink(destination: ItemListScreen(listName: name)){
                            Text(name)
                                .font(.headline)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 8)
                        }
                        Spacer()
                }
                    .padding()
                    .background(Color.backgroundQuinary)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.33)
                    )
                    .contextMenu {
                                     Button(action: {
                                         viewModel.deleteList(list)
                                     }) {
                                         Label("Delete", systemImage: "trash")
                                     }
                                     Button(action: {
                                         selectedListName = list.name
                                         showEditShoppinlistSheet.toggle()
                                     }) {
                                         Label("Edit", systemImage: "pencil")
                                     }
                                     Button(action: {
                                         viewModel.duplicateList(list)
                                     }) {
                                         Label("Duplicate", systemImage: "doc.on.doc")
                                     }
                                 }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive, action: {
                            viewModel.deleteList(list)
                        }) {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button(action: {
                            selectedListName = list.name
                            showEditShoppinlistSheet.toggle()
                        }) {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(Color("ExtraTintSecondary"))
                    }
                }
            
            .listRowInsets(EdgeInsets())
            .listRowSeparator(.hidden)
            
        }
        .padding(.horizontal, 16)
        .listRowSpacing(8)
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
        .background(Color.clear)
        .sheet(isPresented: $showSheet) {
            EmojiGridSheet(emojis: emojis){ emoji in
                if let item = selectedItem {
                    selectedEmojis[item] = emoji
                }
                showSheet = false
            }
        }
        .sheet(isPresented: $showEditShoppinlistSheet){
            
            EditShoppinglistView(viewModel: viewModel, currentListName: $selectedListName, isViewPresented: $showEditShoppinlistSheet)
        }
    
    }
}


#Preview {
    ShoppinglistsListView(viewModel: ShoplistsScreenViewModel())
}
