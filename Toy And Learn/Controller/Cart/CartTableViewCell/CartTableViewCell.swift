//
//  CartTableViewCell.swift
//  Toy And Learn
//
//  Created by user on 02/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    //Outlets
    @IBOutlet weak var toyNameLabel: UILabel!
    @IBOutlet weak var toyPriceLabel: UILabel!
    @IBOutlet weak var toyQuantityLabel: UILabel!
    @IBOutlet weak var toyTotalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
