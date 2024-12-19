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
    @State private var showDeleteAlert = false
    @State private var selectedItem: String?
    @State private var selectedListName: String?
    @State private var selectedEmojis: [String: String] = [:]
    @State private var listToDelete : ShoppingList?

    
    let emojis = [
        AppConstants.AppIcons.listBulletClipboard,
        AppConstants.AppIcons.gift,
        AppConstants.AppIcons.dumbbell,
        AppConstants.AppIcons.paintPalette,
        AppConstants.AppIcons.house,
        AppConstants.AppIcons.graduationCap,
        AppConstants.AppIcons.crossCase,
        AppConstants.AppIcons.tShirt,
        AppConstants.AppIcons.pawPrint,
        AppConstants.AppIcons.cart,
        AppConstants.AppIcons.book,
        AppConstants.AppIcons.partyPopper,
        AppConstants.AppIcons.wrenchAndScrewdriver,
        AppConstants.AppIcons.suitcaseRolling,
        AppConstants.AppIcons.paperclip,
        AppConstants.AppIcons.carrot,
        AppConstants.AppIcons.teddyBear,
        AppConstants.AppIcons.heart,
        AppConstants.AppIcons.forkKnifeCircle,
        AppConstants.AppIcons.briefcase,
        AppConstants.AppIcons.exclamationMark3,
        AppConstants.AppIcons.stroller,
        AppConstants.AppIcons.wineGlass,
        AppConstants.AppIcons.handbag,
        AppConstants.AppIcons.cat,
        AppConstants.AppIcons.camera,
        AppConstants.AppIcons.car,
        AppConstants.AppIcons.appsIPad,
        AppConstants.AppIcons.star,
        AppConstants.AppIcons.eyebrow,
        AppConstants.AppIcons.dog,
        AppConstants.AppIcons.desktop,
        AppConstants.AppIcons.brush,
        AppConstants.AppIcons.cabinet,
        AppConstants.AppIcons.bed,
        AppConstants.AppIcons.smile,
        AppConstants.AppIcons.basket
    
    ]

    
    var body: some View {
        
        List{
            ForEach(viewModel.shoppingLists, id: \.name) { list in
                let name = list.name ?? AppConstants.Texts.unamedText
                
                HStack(spacing: 8){
                    Button{
                        if !showSheet {
                            selectedItem = name
                            showSheet = true
                        }
                    } label: {
                        Image(systemName: selectedEmojis[name] ?? AppConstants.SymbolsName.listBulletClipboard)
                            .frame(width: 44,height: 44)
                            .foregroundColor(.textTetriary)
                            .background(.accentPrimary)
                            .cornerRadius(22)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    
                    NavigationLink(destination: ItemListScreen(shoppingList: list)){
                        Text(name)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 8)
                            .lineLimit(2)
                            .truncationMode(.tail)
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
                .listRowBackground(Color.clear)
                .contextMenu {
                    Button(action: {
                        selectedListName = list.name
                        showEditShoppinlistSheet.toggle()
                    }) {
                        Label(AppConstants.Texts.renameButtonText, systemImage: AppConstants.SymbolsName.pencil)
                    }
                    Button(action: {
                        viewModel.duplicateList(list)
                    }) {
                        Label(AppConstants.Texts.duplicateButtonText, systemImage: AppConstants.SymbolsName.docOnDoc)
                       
                    }
                    Button(role : .destructive){
                        showDeleteAlert.toggle()
                        listToDelete = list
                    }label: {
                        Label(AppConstants.Texts.deleteButtonText, systemImage: AppConstants.SymbolsName.trash)

                    }
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive, action: {
                        showDeleteAlert.toggle()
                        listToDelete = list
                    }) {
                        Label(AppConstants.Texts.deleteButtonText, systemImage: AppConstants.SymbolsName.trash)
                    }
                    
                    Button(action: {
                        selectedListName = list.name
                        showEditShoppinlistSheet.toggle()
                    }) {
                        Label(AppConstants.Texts.editButtonText, systemImage: AppConstants.SymbolsName.pencil)
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
        .alert(AppConstants.Texts.alertTitleText, isPresented: $showDeleteAlert, presenting: listToDelete) { item in
            Button(AppConstants.Texts.cancelText, role: .cancel) {}
            Button(AppConstants.Texts.deleteButtonText, role: .destructive) {
                viewModel.deleteList(item)
            }
        } message: { item in
            Text(AppConstants.Texts.alertConfimationText(item.name ?? AppConstants.Texts.unamedText))
        }
    }
}


#Preview {
    ShoppinglistsListView(viewModel: ShoplistsScreenViewModel())
}
