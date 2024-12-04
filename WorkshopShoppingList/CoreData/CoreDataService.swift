//
//  CoreDataService.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 28.11.2024.
//

import Foundation
import CoreData

final class CoreDataService {
    static let shared = CoreDataService()
    private let context = PersistenceController.shared.container.viewContext
    
    // Fetch all shopping lists
    func fetchShoppingLists() -> [ShoppingList] {
        let request: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        return (try? context.fetch(request)) ?? []
    }
    
    // Add a new shopping list
    func addShoppingList(name: String) {
        let newList = ShoppingList(context: context)
        newList.name = name
        newList.createdAt = Date()
        saveContext()
    }
    
    // Rename an existing shopping list
    func renameShoppingList(_ shoppingList: ShoppingList, newName: String) {
        shoppingList.name = newName
        saveContext()
    }
    
    // Delete a shopping list
    func deleteShoppingList(_ shoppingList: ShoppingList) {
        context.delete(shoppingList)
        saveContext()
    }
    
    // Move an item within a shopping list
    func moveItem(in list: ShoppingList, from sourceIndex: Int, to destinationIndex: Int) {
        guard let itemsSet = list.items as? Set<Item> else { return }
        var items = Array(itemsSet).sorted { $0.name ?? "" < $1.name ?? "" } // Ordenar para consistencia
        let movedItem = items.remove(at: sourceIndex)
        items.insert(movedItem, at: destinationIndex)
        list.items = NSSet(array: items)
        saveContext()
    }
    
    // Add a new item to a shopping list
    func addItem(to list: ShoppingList, name: String, quantity: Double, unit: MeasurementUnit) {
        let newItem = Item(context: context)
        newItem.name = name
        newItem.quantity = quantity
        newItem.unit = unit.rawValue
        newItem.isPurchased = false
        list.addToItems(newItem)
        saveContext()
    }
    
    // Delete an item from a shopping list
    func deleteItem(_ item: Item) {
        context.delete(item)
        saveContext()
    }
    
    // Edit an item's attributes
    func editItem(_ item: Item, name: String? = nil, quantity: Double? = nil, unit: MeasurementUnit? = nil, isPurchased: Bool? = nil) {
        if let name = name {
            item.name = name
        }
        if let quantity = quantity {
            item.quantity = quantity
        }
        if let unit = unit {
            item.unit = unit.rawValue
        }
        if let isPurchased = isPurchased {
            item.isPurchased = isPurchased
        }
        saveContext()
    }
    
    // Duplicate a shopping list
    func duplicateShoppingList(_ shoppingList: ShoppingList) {
        // Crear una nueva lista duplicada
        let newList = ShoppingList(context: context)
        newList.name = (shoppingList.name ?? "") + " (Копия)"
        newList.createdAt = Date()
        
        // Copy items form original list to the new list
        if let items = shoppingList.items as? Set<Item> {
            for item in items {
                let newItem = Item(context: context)
                newItem.name = item.name
                newItem.quantity = item.quantity
                newItem.unit = item.unit
                newItem.isPurchased = item.isPurchased
                newList.addToItems(newItem)
            }
        }
        saveContext()
    }
    
    func deleteAllItems(from shoppingList: ShoppingList) {
        guard let items = shoppingList.items as? Set<Item> else { return }
        for item in items {
            context.delete(item) // Eliminar cada item de la lista
        }
        shoppingList.items = nil // Limpiar la relación
        saveContext()
    }
    
    // Save changes to the context
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving CoreData context: \(error)")
            }
        }
    }
}
