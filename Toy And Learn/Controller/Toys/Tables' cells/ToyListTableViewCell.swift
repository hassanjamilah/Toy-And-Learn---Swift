//
//  ToyListTableViewCell.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class ToyListTableViewCell: UITableViewCell {

    @IBOutlet weak var toyPrice: UILabel!
    @IBOutlet weak var toyAge: UILabel!
    @IBOutlet weak var toyName: UILabel!
    @IBOutlet weak var toyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}