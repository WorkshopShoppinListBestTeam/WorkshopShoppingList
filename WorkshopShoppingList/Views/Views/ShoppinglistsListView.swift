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
    @State private var selectedItem: String?
    @State private var selectedEmojis: [String: String] = [:]
    @State private var doneItems: [String: Bool] = [:]

    let items = ["Подарки", "Еда", "Одежда"]
    let emojis = ["🛒", "🎁", "💝", "🍽️", "🥦", "🍎", "🍌", "🥩", "🧀", "🍞", "🥛", "🥚", "🍗", "🍚", "🥗", "🥔", "🥕", "🌽", "🥜", "🍇", "🍤", "🥤", "🧴", "🧹", "🪣", "🧽", "🪜", "🧼", "🧺", "🛏️", "🪞", "🪑", "👗", "👖", "👕", "🧢", "👠", "👜", "🧥", "🧤", "🧦", "👓", "📱", "💻", "🎧", "📷", "🖨️", "🖥️", "🎮"]

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {
                ForEach(viewModel.shoppingLists, id: \.self) { list in
                    let name = list.name ?? "Sin nombre"
                    HStack {
                        Button(action: {
                            doneItems[name] = !(doneItems[name] ?? false)
                        }) {
                            Image(systemName: doneItems[name] ?? false ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(doneItems[name] ?? false ? .green : .blue)
                                .padding(.trailing, 10)
                        }
                        .contentShape(Rectangle())

                        Button(action: {
                            if !showSheet {
                                selectedItem = name
                                showSheet = true
                            }
                        }) {
                            Text(selectedEmojis[name] ?? "🛒")
                                .font(.largeTitle)
                        }
                        .contentShape(Rectangle())
                        
                        Text(name)
                            .font(.headline)
                            .strikethrough(doneItems[name] ?? false)
                            .foregroundColor(doneItems[name] ?? false ? .gray : .primary)
                            .padding(.leading, 10)

                        Spacer()
                    }
                    .padding()
                    .background(Color(UIColor.systemGroupedBackground))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

//Почти тоже самое что EmojiGridView но в конце есть небольшие изминении
struct EmojiGridSheet: View {
    let emojis: [String]
    let onEmojiSelected: (String) -> Void

    let columns = [
        GridItem(.adaptive(minimum: 40))
    ]

    var body: some View {
        VStack {
            Text("Selecciona un emoji")
                .font(.headline)
                .padding()

            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(emojis, id: \.self) { emoji in
                    Button(action: {
                        onEmojiSelected(emoji)
                    }) {
                        Text(emoji)
                            .font(.largeTitle)
                    }
                }
            }
            .padding()

            Spacer()
        }
        .presentationDetents([.medium])  //Размер на половин экрана
        .presentationDragIndicator(.visible)  //показывает полоску на верзный край sheet'а
    }

}

#Preview {
    ShoppinglistsListView(viewModel: ShoplistsScreenViewModel())
}
