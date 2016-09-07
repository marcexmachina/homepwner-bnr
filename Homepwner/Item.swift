//
//  Item.swift
//  Homepwner
//
//  Created by Marc O'Neill on 09/08/2016.
//  Copyright © 2016 marcondev. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: NSDate
    let itemKey: String
    
    init(name: String, valueInDollars: Int, serialNumber: String?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjs = ["Fluffy", "Rusty", "Hairy", "Fishy"]
            let nouns = ["Leg", "Man", "Chair", "Trumpet"]
            
            //random index
            var idx = arc4random_uniform(UInt32(adjs.count))
            let randomAdj = adjs[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdj) \(randomNoun)"
            
            let randomValue = Int(arc4random_uniform(100))
            let uuid = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            
            self.init(name: randomName, valueInDollars: randomValue, serialNumber: uuid)
            
        } else {
            self.init(name: "", valueInDollars: 0, serialNumber: nil)
        }
    }
    
    func isValueOverFifty() -> Bool {
        return valueInDollars > 50
    }
}
