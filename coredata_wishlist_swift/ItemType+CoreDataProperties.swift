//
//  ItemType+CoreDataProperties.swift
//  coredata_wishlist_swift
//
//  Created by Surasak Wattanapradit on 3/5/2560 BE.
//  Copyright © 2560 Surasak Wattanapradit. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
