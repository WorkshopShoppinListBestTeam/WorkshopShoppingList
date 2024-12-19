//
//  PersistenceController.swift
//  WorkshopShoppingList
//
//  Created by Vladimir Vinakheras on 28.11.2024.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentCloudKitContainer

    init() {
        container = NSPersistentCloudKitContainer(name: "ShoppingListModel")

        guard let storeDescription = container.persistentStoreDescriptions.first else {
            fatalError("No persistent store description found.")
        }

        // Configuración del contenedor de iCloud
        storeDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(
            containerIdentifier: "iCloud.bestTeam.com.WorkshopShoppingList"
        )
        storeDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        storeDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)

        // Cargar las tiendas persistentes
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading persistent stores: \(error.localizedDescription)")
            }
            print("Persistent store loaded: \(description)")
        }

        // Configuración del contexto principal
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
