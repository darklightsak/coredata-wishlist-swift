//
//  Item+CoreDataClass.swift
//  coredata-wishlist-swift
//
//  Created by Surasak Wattanapradit on 3/2/2560 BE.
//  Copyright © 2560 Surasak Wattanapradit. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
