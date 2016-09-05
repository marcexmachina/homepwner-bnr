//
//  ItemCell.swift
//  Homepwner
//
//  Created by Marc O'Neill on 31/08/2016.
//  Copyright © 2016 marcondev. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func updateLabels() {
        let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let captionOneFont = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
        serialNumLabel.font = captionOneFont
    }
    
    
}
