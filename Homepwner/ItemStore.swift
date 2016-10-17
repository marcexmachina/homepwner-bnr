//
//  ItemStore.swift
//  Homepwner
//
//  Created by Marc O'Neill on 09/08/2016.
//  Copyright © 2016 marcondev. All rights reserved.
//

import UIKit

class ItemStore {
    
    var items = [Item]()
    
    let itemArchiveURL: NSURL = {
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent("items.archive")
    }()
    
    init() {
        if let archivedItems = NSKeyedUnarchiver.unarchiveObjectWithFile(itemArchiveURL.path!) as? [Item] {
            items += archivedItems
        }
    }
    
    //Function to create new random item
    func createRandomItem() -> Item {
        let item = Item(random: true)
        items.append(item)
        return item
    }
    
    //Function to delete an item from the item store
    func removeItem(item: Item) {
        if let index = items.indexOf(item) {
            items.removeAtIndex(index)
        }
    }
    
    //Function to reorder the store
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        //keep reference to item being moved
        let movedItem = items[fromIndex]
        //remove item from items
        items.removeAtIndex(fromIndex)
        //reinsert item at new index
        items.insert(movedItem, atIndex: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving Items to \(itemArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(items, toFile: itemArchiveURL.path!)
    }
    
    //function to create URL for an image, by appending image key to document directory URL
    func imageUrlForKey(key: String) -> NSURL{
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory  = documentsDirectories.first!
        return documentDirectory.URLByAppendingPathComponent(key)
    }
    
    
    
    
    
    
    
    
}
