//
//  ChangeDateViewController.swift
//  Homepwner
//
//  Created by Marc O'Neill on 02/09/2016.
//  Copyright © 2016 marcondev. All rights reserved.
//

import UIKit

class ChangeDateViewController: UIViewController {
    
    
    var item: Item!
    
    @IBOutlet var datePicker: UIDatePicker!
        
    @IBAction func newDateSelected(sender: AnyObject) {
        let dateController = sender as! UIDatePicker
        self.item.dateCreated = dateController.date
    }
    
    //Set the datepickers date to be the items dateCreated
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.datePicker.setDate(self.item.dateCreated, animated: false)
    }
}
