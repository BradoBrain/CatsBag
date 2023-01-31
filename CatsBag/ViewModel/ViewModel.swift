//
//  ViewModel.swift
//  CatsBag
//
//  Created by Artem Vinogradov on 30.12.2022.
//

import Foundation
import SwiftUI

// DOCUMENTATION:
/**
 ViewModel is class that has all the methods to manage the views and data model.
 
 - Here is coomon method to save context of data model
 ```
 func save() {
     do {
         try context.save()
     } catch let error {
         print("Error saving: \(error.localizedDescription)")
     }
 }
 ```
 
 - Here are methods for folders:
    - Add new folder
 ```
 func addFolder() {
     let newFolder = FolderEntity(context: context)
     newFolder.name = folderName
     save()
 }
 ```
    - Delete folder
 ```
 func deleteFolder(offsets: IndexSet, folders: FetchedResults<FolderEntity>) {
     offsets
         .map { folders[$0] }
         .forEach(context.delete)
     save()
 }
 ```
 - Here are methods for items:
    - Add item
 ```
 func addItem(folder: FolderEntity) {
     let newItem = ItemEntity(context: context)
     if itemNumber.isEmpty {
         newItem.name = itemName
         newItem.number = ""
         newItem.measurement = ""
         newItem.category = itemCategory
         newItem.folderName = folder.name
         newItem.done = false
         newItem.id = UUID()
     } else {
         newItem.name = itemName
         newItem.number = itemNumber
         newItem.measurement = itemMeasurement
         newItem.category = itemCategory
         newItem.folderName = folder.name
         newItem.done = false
         newItem.id = UUID()
     }
     folder.addToItems(newItem)
     save()
 }
 ```
    - Update item
 ```
 func updateItem(item: ItemEntity, name: String, number: String, measurement: String, category: String) {
     if number.isEmpty {
         item.name = name
         item.number = ""
         item.measurement = ""
         item.category = category
     } else {
         item.name = name
         item.number = number
         item.measurement = measurement
         item.category = category
     }
     save()
 }
 ```
    - Delete item
 ```
 func deleteItems(offsets: IndexSet, items: FetchedResults<ItemEntity>) {
     for index in offsets {
         let item = items[index]
         context.delete(item)
     }
     save()
 }
 ```
    - Get color for item with categoty type
 ```
 func getColor(item: ItemEntity) -> Color {
     switch item.category {
     case "Bread & Flour":
         return Color("bread")
     case "Drinks":
         return Color("drink")
     case "Fish & Seafood":
         return Color("fish")
     case "Fruit":
         return Color("fruit")
     case "Meat & Soy":
         return Color("meat")
     case "Milk & Egg":
         return Color("milk")
     case "Mushrooms":
         return Color("mushroom")
     case "Nuts & Seeds":
         return Color("nut")
     case "Fat & Oil":
         return Color("oil")
     case "Sweets & Candy":
         return Color("sweet")
     case "Vagetables":
         return Color("vagetable")
     default:
         return Color("default")
     }
 }
 ```
 */
class ViewModel: ObservableObject {
    // CoreData context
    let context = PersistenceController.shared.container.viewContext
    // MARK: - Folder properties
    @Published var folderName = ""
    // MARK: - Item properties
    @Published var itemName = ""
    @Published var itemNumber = ""
    @Published var itemMeasurement = "it"
    @Published var itemCategory = "Uncategorized"
    // MARK: - Folder part
    /// Method to add new folder with name
    func addFolder() {
        let newFolder = FolderEntity(context: context)
        newFolder.name = folderName
        save()
    }
    /// Method to delete  folder
    func deleteFolder(offsets: IndexSet, folders: FetchedResults<FolderEntity>) {
        offsets
            .map { folders[$0] }
            .forEach(context.delete)
        save()
    }
    // MARK: - Item part
    /// Method to add new item
    func addItem(folder: FolderEntity) {
        let newItem = ItemEntity(context: context)
        if itemNumber.isEmpty {
            newItem.name = itemName
            newItem.number = ""
            newItem.measurement = ""
            newItem.category = itemCategory
            newItem.folderName = folder.name
            newItem.done = false
            newItem.id = UUID()
        } else {
            newItem.name = itemName
            newItem.number = itemNumber
            newItem.measurement = itemMeasurement
            newItem.category = itemCategory
            newItem.folderName = folder.name
            newItem.done = false
            newItem.id = UUID()
        }
        folder.addToItems(newItem)
        save()
    }
    /// Method to update new current item
    func updateItem(item: ItemEntity, name: String, number: String, measurement: String, category: String) {
        if number.isEmpty {
            item.name = name
            item.number = ""
            item.measurement = ""
            item.category = category
        } else {
            item.name = name
            item.number = number
            item.measurement = measurement
            item.category = category
        }
        save()
    }
    /// Method to delete item
    func deleteItems(offsets: IndexSet, items: FetchedResults<ItemEntity>) {
        for index in offsets {
            let item = items[index]
            context.delete(item)
        }
        save()
    }
    /// Method to get color for item with user's choose
    func getColor(item: ItemEntity) -> Color {
        switch item.category {
        case "Bread & Flour":
            return Color("bread")
        case "Drinks":
            return Color("drink")
        case "Fish & Seafood":
            return Color("fish")
        case "Fruit":
            return Color("fruit")
        case "Meat & Soy":
            return Color("meat")
        case "Milk & Egg":
            return Color("milk")
        case "Mushrooms":
            return Color("mushroom")
        case "Nuts & Seeds":
            return Color("nut")
        case "Fat & Oil":
            return Color("oil")
        case "Sweets & Candy":
            return Color("sweet")
        case "Vagetables":
            return Color("vagetable")
        default:
            return Color("default")
        }
    }
    // MARK: - Common part
    /// Method to save context of CoreData
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving: \(error.localizedDescription)")
        }
    }
}
