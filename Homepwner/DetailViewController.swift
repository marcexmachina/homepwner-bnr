//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Marc O'Neill on 31/08/2016.
//  Copyright © 2016 marcondev. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var serialNumTextField: UITextField!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var dateCreatedLabel: UILabel!
    
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //Item selected in tableview
    var item: Item! {
        didSet {
            self.navigationItem.title = item.name

        }
    }
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameTextField.text = item.name
        serialNumTextField.text = item.serialNumber
        valueTextField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateCreatedLabel.text = dateFormatter.stringFromDate(item.dateCreated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialNumTextField.text
        
        
        if let valueText = valueTextField.text,
            value = numberFormatter.numberFromString(valueText) {
            item.valueInDollars = value.integerValue
        } else {
            item.valueInDollars = 0
        }
        //resign first responder
        view.endEditing(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ChangeDate" {
            let changeDateViewController = segue.destinationViewController as! ChangeDateViewController
            changeDateViewController.item = self.item
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
