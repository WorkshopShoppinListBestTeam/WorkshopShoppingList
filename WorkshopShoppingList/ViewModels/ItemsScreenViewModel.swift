//
//  ItemsScreenViewModel.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import Foundation
import Combine

final class ItemsScreenViewModel: ObservableObject {
    @Published var items: [Item] = []
    private let shoppingList: ShoppingList
    private let coreDataService = CoreDataService.shared
    
    init(shoppingList: ShoppingList) {
        self.shoppingList = shoppingList
        fetchItems()
    }
    
    func fetchItems() {
        items = shoppingList.itemsArray
        purchasedOrderingItemsList()
    }
    
    func alphaOrderingItemsList(){
        items.sort { $0.name ?? "" < $1.name ?? "" }
    }
    
    func purchasedOrderingItemsList(){
        items = items.sorted {
            if $0.isPurchased != $1.isPurchased {
                return !$0.isPurchased
            }
            let name1 = $0.name ?? ""
            let name2 = $1.name ?? ""
            return name1.localizedCaseInsensitiveCompare(name2) == .orderedAscending
        }
    }
    
    func addItem(name: String, quantity: Double, unit: MeasurementUnit) -> Bool {
        let doesNotContainItem = true
        guard !name.isEmpty, !items.contains(where: { $0.name == name }) else { return !doesNotContainItem }
        coreDataService.addItem(to: shoppingList, name: name, quantity: quantity, unit: unit)
        fetchItems()
        return doesNotContainItem
    }
    
    func deleteItem(_ item: Item) {
        coreDataService.deleteItem(item)
        fetchItems()
    }
    
    func editItem(currentItemName: String?, name: String, quantity: Double, unit: MeasurementUnit, isPurchased: Bool) {
        if let item = items.first(where: { $0.name == currentItemName }) {
            coreDataService.editItem(item, name: name, quantity: quantity, unit: unit, isPurchased: isPurchased)
            fetchItems()
        }
    }
    
    func itemAlreadyExists(_ name: String) -> Bool {
        return items.contains(where: { $0.name == name })
    }
    
    func deleteAllItems() {
        coreDataService.deleteAllItems(from: shoppingList)
        fetchItems()
    }
    
    func deleteAllBought(){
        for item in items where item.isPurchased {
            coreDataService.deleteItem(item)
        }
        fetchItems()
    }
    
    func togglePurchased(for item: Item) {
        if let index = items.firstIndex(where: { $0.name == item.name }) {
            items[index].isPurchased.toggle()
            print(items[index].isPurchased)
            coreDataService.editItem(item, name: item.name, quantity: item.quantity, unit: MeasurementUnit(rawValue: item.unit ?? MeasurementUnit.pieces.rawValue ), isPurchased: item.isPurchased)
        }
        fetchItems()
    }
}
