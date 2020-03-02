//
//  UIHelper.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation
import UIKit
class UIHelper {
    enum iconsNames:String{
        case fav_empty = "fav_empty"
        case fav_filled = "fav_filled"
    }
    
    enum MessagesContents :String {
        case errorLaodingCats = "Can not load the categories"
        case errorLodingToysList = "Can not load the toys list"
        case errorLodingStoriesList = "Can not load the stories list"
    }
    
    enum MessageTitles:String {
        case errorLoadingCats = "Error loding categories"
         case errorLodingToysList = "Error loading toys list"
         case errorLodingStoriesList = "Error loading stories list"
    }
    
    class func showAlertDialog(message:MessagesContents , title:MessageTitles , sourceController:UIViewController){
        let alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        sourceController.present(alert, animated: true, completion: nil)
    }
    
    
    class func showIndicator (loadingIndicator:UIActivityIndicatorView, show:Bool){
           if show {
               loadingIndicator.startAnimating()
               loadingIndicator.isHidden = false
           }else {
               loadingIndicator.stopAnimating()
               loadingIndicator.isHidden = true
           }
       }

}
