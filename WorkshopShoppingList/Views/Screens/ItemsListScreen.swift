//
//  ItemsListScreen.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 07.12.2024.
//

import SwiftUI

struct ItemListScreen: View {
    let listName: String

    var body: some View {
        VStack {
            Text("Items for \(listName)")
                .font(.largeTitle)
                .padding()

            Spacer()
        }
        .navigationTitle(listName)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    ItemListScreen(listName: "My List")
}
