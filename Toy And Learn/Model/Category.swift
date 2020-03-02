//
//  Category.swift
//  Toy And Learn
//
//  Created by Hassan on 29/02/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation

struct AllCats:Codable{
    let categories:[Category]
}

struct Category:Codable {
    
    
    let categoryID:Int
    let categoryName:String
    let categoryImageName:String
    
    enum CodingKeys:String , CodingKey{
        case categoryID = "catId"
        case categoryName = "catName"
        case categoryImageName = "catImageName"
    }
    
}
