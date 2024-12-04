//
//  ShoplistPageViewModel.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import Foundation
import Combine

final class ShoplistPageViewModel: ObservableObject {
    @Published private(set) var items: [Item] = []
    private let shoppingList: ShoppingList
    private let coreDataService = CoreDataService.shared
    
    init(shoppingList: ShoppingList) {
        self.shoppingList = shoppingList
        fetchItems()
    }
    
    func fetchItems() {
        items = shoppingList.itemsArray
            .sorted { $0.name ?? "" < $1.name ?? "" }
    }
    
    func alphaOrderingItemsList(){
        items.sort { $0.name ?? "" < $1.name ?? "" }
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
    
    func editItem(_ item: Item, name: String? = nil, quantity: Double? = nil, unit: MeasurementUnit? = nil, isPurchased: Bool? = nil) {
        coreDataService.editItem(item, name: name, quantity: quantity, unit: unit, isPurchased: isPurchased)
        fetchItems()
    }
    
    func moveItem(from sourceIndex: Int, to destinationIndex: Int) {
        coreDataService.moveItem(in: shoppingList, from: sourceIndex, to: destinationIndex)
        fetchItems()
    }
    
    func itemAlreadyExists(_ name: String) -> Bool {
        return items.contains(where: { $0.name == name })
    }
    
    func deleteAllItems() {
        coreDataService.deleteAllItems(from: shoppingList)
        fetchItems()
    }
}

extension ShoppingList {
    var itemsArray: [Item] {
        (items?.allObjects as? [Item]) ?? []
    }
}
