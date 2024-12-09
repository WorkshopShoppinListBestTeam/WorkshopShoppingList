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
    @State private var doneItems: [String: Bool] = [:]
    
    var body: some View {
        ForEach(viewModel.items, id: \.self) { item in
            let name = item.name ?? "Unamed item"
            let quantity = item.quantity
            let measurement = item.unit ?? MeasurementUnit.pieces.rawValue
            
            HStack {
                Button(action: {
                 
                    doneItems[name] = !(doneItems[name] ?? false)
                }) {
                    Image(systemName: doneItems[name] ?? false ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(doneItems[name] ?? false ? .green : .blue)
                        .padding(.trailing, 10)
                }
                .contentShape(Rectangle())
            
                Text(name)
                    .font(.headline)
                    .strikethrough(doneItems[name] ?? false)  //Зачеркнуть текст
                    .foregroundColor(doneItems[name] ?? false ? .gray : .primary)
                    .padding(.leading, 10)
                Spacer()
                
                if(quantity != 0){
                    Text("\(quantity) \(measurement)")
                        
                }
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground))
            .cornerRadius(10)
            
        }    }
}

#Preview {
    ItemsListView(viewModel: ItemsScreenViewModel(shoppingList: ShoppingList()))
}
