//
//  Story.swift
//  Toy And Learn
//
//  Created by Hassan on 29/02/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation

struct Story:Codable{
    let storyHtmlURLString:String
    let storyServerID:Int
    let storyImageName:String
    let storyMaxAge:Int
    let storyMinAge:Int
    let storyDescription:String
    let storyTitle:String
    
    enum CodingKeys:String , CodingKey{
        case storyHtmlURLString = "Story_Html_Url"
        case storyServerID = "Story_ID"
        case storyImageName = "Story_Image_Name"
        case storyMaxAge = "Story_Max_Age"
        case storyMinAge = "Story_Min_Age"
        case storyDescription = "Story_Min_Desc"
        case storyTitle = "Story_Title"
    }
}
