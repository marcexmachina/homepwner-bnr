//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Marc O'Neill on 09/08/2016.
//  Copyright © 2016 marcondev. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    let uiTableViewCell = "UITableViewCell"
    var imageStore: ImageStore!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //compute row height based on Vertical constraint between nameLabel/serialNumLabel
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //always have at least one cell
        return itemStore.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //create an instance of UITableViewCell with default appearance
        ///let cell = UITableViewCell(style: .Value1, reuseIdentifier: "UITableViewCell")
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell", forIndexPath: indexPath) as! ItemCell
        cell.updateLabels()
        //item at nth row of tableview = nth item in itemStore.items
        let item = itemStore.items[indexPath.row]
        //if item value > 50 then text colour is green, value < 50 text colour is red
        if item.isValueOverFifty() {
            cell.valueLabel.textColor = UIColor.greenColor()
        } else {
            cell.valueLabel.textColor = UIColor.redColor()
        }
        cell.nameLabel.text = item.name
        cell.serialNumLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        cell.textLabel?.font = UIFont(name: "San Francisco", size: 20)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == itemStore.items.count {
            return CGFloat(44)
        } else {
            return CGFloat(60)
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //If tableview is asking to commit a delete
        if editingStyle == .Delete && indexPath.row != itemStore.items.count{
            //remove item from itemstore
            let item = itemStore.items[indexPath.row]
            
            //Alert Actioncontroller
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .ActionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
            let deleteAction = UIAlertAction(title: "Remove", style: .Destructive, handler: {
                (action) -> Void in
                
                    if(indexPath.row != self.itemStore.items.count) {
                        //remove item from itemstore
                        self.itemStore.removeItem(item)
                        self.imageStore.deleteImageForKey(item.itemKey)
                        //remove item from tableview with animation
                        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    }
            })
            
            //add actions to alert controller
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            
            //show Alert
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath,
                            toIndexPath destinationIndexPath: NSIndexPath) {
        
        if(sourceIndexPath.row != itemStore.items.count){
            itemStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
        }
    }
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath,
                            toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        
        if sourceIndexPath.row == itemStore.items.count
            || proposedDestinationIndexPath.row == itemStore.items.count {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.row == self.itemStore.items.count {
            return false
        } else {
            return true
        }
    }
    
    //Function to pass selected item from table to Item Details screen
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowItem" {
            //figure out which row was selected
            if let row = tableView.indexPathForSelectedRow?.row {
                let item = itemStore.items[row]
                let detailController = segue.destinationViewController as! DetailViewController
                detailController.item = item
                detailController.imageStore = self.imageStore
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    // IBActions---------------------------------------------------------------------------------------------------------
    
    @IBAction func addnewItem(sender: AnyObject) {
        let newItem = itemStore.createRandomItem()
        if let index = itemStore.items.indexOf(newItem) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}
