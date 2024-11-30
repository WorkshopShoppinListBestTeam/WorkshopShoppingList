//
//  ShoplistsScreen.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import SwiftUI

struct ShoplistsScreen: View {
    @State private var showCreatingNewListSheet: Bool = false
    var body: some View {
        VStack{
            Spacer()
            Button(action: {
                showCreatingNewListSheet.toggle()
            }){
                Text("Добавить новый список")
            }
            .frame(width: .infinity, height: 50)
            .padding(.horizontal, 16)
            Spacer()
        }
        .shee
    }
}
#Preview {
    ShoplistsScreen()
}
