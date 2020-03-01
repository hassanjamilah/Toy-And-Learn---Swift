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
    enum MessagesContents :String {
        case errorLaodingCats = "Can not load the categories"
        case errorLodingToysList = "Can not load the toys list"
    }
    
    enum MessageTitles:String {
        case errorLoadingCats = "Error loding categories"
         case errorLodingToysList = "Error loading toys list"
    }
    
    class func showAlertDialog(message:MessagesContents , title:MessageTitles , sourceController:UIViewController){
        let alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        sourceController.present(alert, animated: true, completion: nil)
    }
}
