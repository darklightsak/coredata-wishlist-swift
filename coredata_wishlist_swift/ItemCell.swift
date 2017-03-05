//
//  ItemCell.swift
//  coredata_wishlist_swift
//
//  Created by Surasak Wattanapradit on 3/5/2560 BE.
//  Copyright © 2560 Surasak Wattanapradit. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!

    func configureCell(item: Item) {
        
        title.text = item.title //attibite for entity
        price.text = "฿\(item.price)"
        details.text = item.details
    }
    

}
