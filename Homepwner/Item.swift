//
//  Item.swift
//  Homepwner
//
//  Created by Marc O'Neill on 09/08/2016.
//  Copyright © 2016 marcondev. All rights reserved.
//

import UIKit

class Item: NSObject, NSCoding {
    
    // MARK: global variables
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: NSDate
    let itemKey: String
    
    // MARK: inits
    init(name: String, valueInDollars: Int, serialNumber: String?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.serialNumber = aDecoder.decodeObjectForKey("serialNumber") as! String?
        self.dateCreated = aDecoder.decodeObjectForKey("dateCreated") as! NSDate
        self.itemKey = aDecoder.decodeObjectForKey("itemKey") as! String
        self.valueInDollars = aDecoder.decodeIntegerForKey("valueInDollars")
        
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
    
    // MARK: encoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(serialNumber, forKey: "serialNumber")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(itemKey, forKey: "itemKey")
        aCoder.encodeInteger(valueInDollars, forKey: "valueInDollars")
    }
    
    func isValueOverFifty() -> Bool {
        return valueInDollars > 50
    }
}
