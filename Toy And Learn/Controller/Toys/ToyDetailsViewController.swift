//
//  ToyDetailsViewController.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class ToyDetailsViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var toyImageView: UIImageView!
    @IBOutlet weak var toyNextImageButton: UIButton!
    @IBOutlet weak var toyPreviosImageButton: UIButton!
    @IBOutlet weak var toyNumImagesLabel: UILabel!
    @IBOutlet weak var toyNameLabel: UILabel!
    @IBOutlet weak var toyAgeLabel: UILabel!
    @IBOutlet weak var toyPriceLabel: UILabel!
    @IBOutlet weak var toyFavoriteButton: UIButton!
    @IBOutlet weak var toyDescriptionTextView: UITextView!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var imageLoadingIndicatore: UIActivityIndicatorView!
    
    
    var toy:Toy!
    var allImages:[String]!
    var currentImageIndex:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadToy()
       
    }
    
    func loadToy(){
        loadImage()
       setImageNumLabelText()
        toyNameLabel.text = toy.toyName
        toyAgeLabel.text = "\(toy.toyMinAge) - \(toy.toyMaxAge) Years"
        toyPriceLabel.text = "\(toy.toyPrice)$"
        toyDescriptionTextView.text = toy.toyDescription
       
    }
    
    func loadImage(){
        showImageLoadingIndicator(show: true)
        allImages = toy.getImagesArray()
        let url = NetworkHelper.getImageURL(imageName: allImages[currentImageIndex])
        NetworkHelper.loadImageFromURL(url: url) { (image, error) in
            if let image = image {
                self.toyImageView.image = image
            }
            self.showImageLoadingIndicator(show: false)
            self.setImageNumLabelText()
        }
    }
    
    @IBAction func nextImageAction(_ sender: Any) {
        currentImageIndex += 1
        if currentImageIndex >= allImages.count{
            currentImageIndex = 0
        }
        loadImage()
        
    }
    
    @IBAction func addToCartAction(_ sender: Any) {
        showQuanittyAlert()
    
    }
    
    
    @IBAction func previousImageAction(_ sender: Any) {
        currentImageIndex -= 1
        if currentImageIndex < 0 {
            currentImageIndex = allImages.count - 1
        }
        loadImage()
    }
    
    @IBAction func shareAction(_ sender: Any) {
    }
    
    @IBAction func addToFavAction(_ sender: Any) {
        MaterialDataUtils.addMaterialToFavoritesAndCart(toy: toy, isFavorit: true, isCart: false, quantity: nil )
    }
    
    func showQuanittyAlert(){
        
            let alert = UIAlertController(title: "Quantity", message: "Enter a quantity:", preferredStyle: .alert)

            // Create actions
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let saveAction = UIAlertAction(title: "OK", style: .default) { [weak self] action in
                if let quan = alert.textFields?.first?.text {
                    self?.addToCart(quant: quan)
                }
            }
            saveAction.isEnabled = false

            // Add a text field
            alert.addTextField { textField in
                textField.placeholder = "Quantity"
                NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: .main) { notif in
                    if let text = textField.text, !text.isEmpty {
                        saveAction.isEnabled = true
                    } else {
                        saveAction.isEnabled = false
                    }
                }
            }

            alert.addAction(cancelAction)
            alert.addAction(saveAction)
            present(alert, animated: true, completion: nil)
        
    }
    
    func addToCart(quant:String){
        let quan = Int64(quant)
        MaterialDataUtils.addMaterialToFavoritesAndCart(toy: toy, isFavorit: false, isCart: true, quantity: quan)
    }
    
    func showImageLoadingIndicator(show:Bool){
        if show {
            imageLoadingIndicatore.startAnimating()
            imageLoadingIndicatore.isHidden = false
            toyImageView.image = nil
        }else {
            imageLoadingIndicatore.stopAnimating()
            imageLoadingIndicatore.isHidden = true
            
            
        }
    }
    

    func setImageNumLabelText (){
         toyNumImagesLabel.text = "\(currentImageIndex+1) \\ \(allImages.count)"
    }

}
