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
        
    @IBAction func newDateSelected(sender: AnyObject) {
        let datePicker = sender as! UIDatePicker
        item.dateCreated = datePicker.date
    }
}
