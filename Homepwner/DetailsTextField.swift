//
//  DetailsTextField.swift
//  Homepwner
//
//  Created by Marc O'Neill on 02/09/2016.
//  Copyright © 2016 marcondev. All rights reserved.
//

import UIKit

class DetailsTextField: UITextField {
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        self.borderStyle = .Bezel
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        self.borderStyle = .RoundedRect
        return true
    }
}
