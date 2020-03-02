//
//  ApiClient.swift
//  Toy And Learn
//
//  Created by user on 29/02/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation

class ApiClient {
    /**
     Get All the categories of the toys
     */
    class func getAllToysCategories(handler:@escaping([Category]? , String?)->Void){
        let url = NetworkHelper.EndPoints.getAllToysCats.url
        NetworkHelper.taskForGetRequest(url: url, responseType: AllCats.self) { (categories, error) in
            
                if let allCats = categories {
                    print (allCats.categories)
                    handler(allCats.categories , nil )
                }else {
                    print ("Error in getting all categories : \(error?.localizedDescription ?? "Unknown error")")
                    handler(nil , "Error in getting the categories \(error?.localizedDescription ?? "Unknown error")")
                }
            
            
        }
        
    }
    
    /**
     Search for toy :
     Parameters :
     categoryID : The category id to search in
     minAge : The minmum age required
     maxAge : The max age required
     keyword : Search in the title and description to find this keyword
     */
    class func searchToy(categoryID:Int , minAge:Int , maxAge:Int , keyword:String , handler:@escaping([Toy]? , String? )->Void){
        let url = NetworkHelper.EndPoints.searchToy(categoryID, minAge, maxAge, keyword).url
        NetworkHelper.taskForGetRequest(url: url, responseType: AllToys.self) { (allToys, error) in
            DispatchQueue.main.async {
                if let allToys = allToys {
                    handler(allToys.toys , nil )
                }else {
                    print ("Error getting the toys : \(error?.localizedDescription ?? "Unknown error")")
                    handler(nil , "Error getting the toys : \(error?.localizedDescription ?? "Unknown error")")
                }
            }
            
        }
    }
    
    /**
     Searh for stories
     minAge : The minimum age required
     maxAge : The max age required
     keyword : Search in the title and description to find this keyword
     */
    class func searchStory (minAge:Int , maxAge:Int , keyword:String , handler:@escaping([Story]? , String? )->Void){
        let url = NetworkHelper.EndPoints.SearchStory(minAge, maxAge, keyword).url
        NetworkHelper.taskForGetRequest(url: url, responseType: AllStories.self) { (allStories, error) in
            DispatchQueue.main.async {
                if let allStories = allStories {
                    handler(allStories.stories , nil )
                }else {
                    handler(nil , "Error getting the stories \(error?.localizedDescription ?? "Unknown error")")
                }
            }
            
        }
    }
    
}
