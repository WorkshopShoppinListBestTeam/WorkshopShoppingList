//
//  ShoplistsScreenViewModel.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 30.11.2024.
//

import Foundation
import Combine

final class ShoplistsScreenViewModel: ObservableObject {
    @Published private(set) var shoppingLists: [ShoppingList] = []
    private let coreDataService = CoreDataService.shared
    
    init() {
        fetchLists()
    }
    
    func fetchLists() {
        shoppingLists = coreDataService.fetchShoppingLists()
    }
    
    func addList(name: String) {
        guard !name.isEmpty, !shoppingLists.contains(where: { $0.name == name }) else { return }
        coreDataService.addShoppingList(name: name)
        fetchLists()
    }
    
    func deleteList(_ shoppingList: ShoppingList) {
        coreDataService.deleteShoppingList(shoppingList)
        fetchLists()
    }
    
    func renameList(_ shoppingList: ShoppingList, newName: String) {
        guard !newName.isEmpty else { return }
        coreDataService.renameShoppingList(shoppingList, newName: newName)
        fetchLists()
    }
    
    func shoppinglistAlreadyExists(_ name: String) -> Bool {
        return shoppingLists.contains(where: { $0.name == name })
    }
    
    func duplicateList(_ shoppingList: ShoppingList) {
        coreDataService.duplicateShoppingList(shoppingList)
        fetchLists()
    }
}
