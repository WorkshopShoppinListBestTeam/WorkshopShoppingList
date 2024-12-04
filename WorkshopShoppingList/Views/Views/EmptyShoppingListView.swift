//
//  EmptyShoppingListView.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import SwiftUI
import Combine

struct EmptyShoppingListView: View {
    @Binding var showCreatingNewListSheet: Bool
    var body: some View {
        VStack{
            Spacer()
            Button(action: {
                showCreatingNewListSheet.toggle()
            }){
                Text("Добавить новый список")
            }
            .frame(width: 343, height: 50)
            .background(Color.pink.opacity(0.60))
            .cornerRadius(14)
            .padding(.horizontal, 16)
            Spacer()
        }
    }
}

#Preview {
    EmptyShoppingListView(showCreatingNewListSheet: .constant(false))
}
