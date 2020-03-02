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
    
    let loadingIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    override func awakeFromNib() {
        super.awakeFromNib()
        if let toyImage =   toyImage{
            loadingIndicator.frame = toyImage.frame
        }
        
        toyImage.addSubview(loadingIndicator)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func showIndicator(){
        UIHelper.showIndicator(loadingIndicator: loadingIndicator, show: true)
    }
    
    func loadImage(imageName:String){
        UIHelper.showIndicator(loadingIndicator: loadingIndicator, show: true)
        let url = NetworkHelper.getImageURL(imageName: imageName)
        NetworkHelper.loadImageFromURL(url: url, handler: { (image, error) in
            if let image = image {
                self.toyImage.image = image
            }
            UIHelper.showIndicator(loadingIndicator: self.loadingIndicator, show: false)
        })
    }
    
    /**
     Used in the categories view controller when doing search for a toy
     */
    func setupForCatToySearch(){
        toyPrice.isHidden  = true
        toyName.isHidden = true
        
    }
    

}
