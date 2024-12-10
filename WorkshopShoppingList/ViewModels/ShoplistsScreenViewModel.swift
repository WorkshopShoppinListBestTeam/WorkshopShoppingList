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
    
    func renameList(currentName: String, newName: String) {
        guard !newName.isEmpty, !shoppinglistAlreadyExists(newName) else { return }
        
        if let shoppingList = shoppingLists.first(where: { $0.name == currentName }) {
            coreDataService.renameShoppingList(shoppingList, newName: newName)
            fetchLists()
        }
    }

    func shoppinglistAlreadyExists(_ name: String) -> Bool {
        return shoppingLists.contains(where: { $0.name == name })
    }
    
    func duplicateList(_ shoppingList: ShoppingList) {
        coreDataService.duplicateShoppingList(shoppingList)
        fetchLists()
    }
    
    func filteringShoppingLists(for query: String) {
        fetchLists()
        guard !query.isEmpty else { return }
        shoppingLists =  shoppingLists.filter { $0.name?.localizedCaseInsensitiveContains(query) == true }
    }
    
    func removeAll(){
        for shoppingList in shoppingLists {
            coreDataService.deleteShoppingList(shoppingList)
        }
        fetchLists()
    }
}
