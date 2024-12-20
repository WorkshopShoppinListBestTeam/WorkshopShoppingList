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
    
  
    func fetchShoppingLists() -> [ShoppingList] {
        let request: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        return (try? context.fetch(request)) ?? []
    }
    

    func addShoppingList(name: String) {
        let newList = ShoppingList(context: context)
        newList.name = name
        newList.createdAt = Date()
        saveContext()
    }
    

    func renameShoppingList(_ shoppingList: ShoppingList, newName: String) {
        shoppingList.name = newName
        saveContext()
    }
    

    func deleteShoppingList(_ shoppingList: ShoppingList) {
        context.delete(shoppingList)
        saveContext()
    }
   
    func moveItem(in list: ShoppingList, from sourceIndex: Int, to destinationIndex: Int) {
        guard let itemsSet = list.items as? Set<Item> else { return }
        var items = Array(itemsSet).sorted { $0.name ?? "" < $1.name ?? "" }
        let movedItem = items.remove(at: sourceIndex)
        items.insert(movedItem, at: destinationIndex)
        list.items = NSSet(array: items)
        saveContext()
    }
    
    func addItem(to list: ShoppingList, name: String, quantity: Double, unit: MeasurementUnit) {
        let newItem = Item(context: context)
        newItem.name = name
        newItem.quantity = quantity
        newItem.unit = unit.rawValue
        newItem.isPurchased = false
        list.addToItems(newItem)
        saveContext()
    }
    
    func deleteItem(_ item: Item) {
        context.delete(item)
        saveContext()
    }
    
    
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
    
    
    func duplicateShoppingList(_ shoppingList: ShoppingList) {
        
        let newList = ShoppingList(context: context)
        newList.name = (shoppingList.name ?? "") + " (Копия)"
        newList.createdAt = Date()
        
        
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
            context.delete(item)
        }
        shoppingList.items = nil
        saveContext()
    }
    
    func syncWithICloudOnStartup() {
        let context = PersistenceController.shared.container.viewContext

        let fetchRequest: NSFetchRequest<ShoppingList> = ShoppingList.fetchRequest()
        do {
            let _ = try context.fetch(fetchRequest) 
            print("Initial sync with iCloud completed.")
        } catch {
            print("Error syncing with iCloud: \(error.localizedDescription)")
        }
    }
    
    
    private func saveContext() {
        let context = PersistenceController.shared.container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Context saved successfully.")
            } catch {
                print("Error saving context: \(error.localizedDescription)")
            }
        }
    }

}
