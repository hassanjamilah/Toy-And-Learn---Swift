//
//  Toy.swift
//  Toy And Learn
//
//  Created by Hassan on 29/02/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation

struct AllToys:Codable{
    let toys:[Toy]
}

struct Toy:Codable{
    
    let toyMaxAge:Int
    let toyMinAge:Int
    let toyCategoryID:Int
    let toyDescription:String
    let toyServerID:Int
    let toyImagesString:String
    let toyName:String
    let toyPrice:Int
    
    enum CodingKeys:String , CodingKey{
        case toyMaxAge = "Toy_Age_Max"
        case toyMinAge = "Toy_Age_Min"
        case toyCategoryID = "Toy_CatID"
        case toyDescription = "Toy_Desc"
        case toyServerID = "Toy_ID"
        case toyImagesString = "Toy_Images_Names"
        case toyName = "Toy_Name"
        case toyPrice = "Toy_Price"
    }
    
     func getImagesArray()->[String]{
        print("The toy images string is :\(toyImagesString)")
        let images = toyImagesString.components(separatedBy: ",")
        return images
       
       
    }
    
}
