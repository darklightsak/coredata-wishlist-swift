//
//  ItemCell.swift
//  coredata-wishlist-swift
//
//  Created by Surasak Wattanapradit on 3/2/2560 BE.
//  Copyright © 2560 Surasak Wattanapradit. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
