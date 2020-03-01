//
//  NetworkHelper.swift
//  Toy And Learn
//
//  Created by user on 29/02/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation
import UIKit
class NetworkHelper {
    
    enum EndPoints {
        static let base_url = "https://toyandlearn.000webhostapp.com/"
        static let images_base_url = EndPoints.base_url + "images/"
        
        case getAllToysCats
        case searchToy(Int , Int , Int , String)
        case SearchStory (Int , Int , String)
        
        var urlString:String {
            switch self {
            case .getAllToysCats:
                return EndPoints.base_url + "get_all_toy_cats.php"
            case .SearchStory(let minAge, let maxAge , let keyWord):
                return EndPoints.base_url + "get_story.php?minage=\(minAge)&maxage=\(maxAge)&keyword=\(keyWord)"
            case .searchToy(let catID ,  let minAge, let maxAge , let keyWord):
                return EndPoints.base_url + "get_toy.php?catid=\(catID)&minage=\(minAge)&maxage=\(maxAge)&keyword=\(keyWord)"
             
           
            }
        }
        
        
        
        var url:URL {
            return URL(string: urlString)!
        }
        
        
    }
    
    /**
     Used to do the api get requests
     */
    class func taskForGetRequest<ResponseType:Decodable>(url:URL , responseType:ResponseType.Type , handler:@escaping(ResponseType? , Error?)->Void){
        print ("The url is : \(url)"  )
        let task = URLSession.shared.dataTask(with: url) { (data, resonse, error) in
            if let data = data {
                let response = self.deocdeData(data: data, responseType: responseType)
                if let response = response {
                    handler(response , nil )
                }else {
                    handler(nil , error)
                }
            }else {
                handler(nil , error )
            }
        }
        task.resume()
    }
    
    /**
     used to decode the data and convert the jsons results to suitable structs
     */
    class func deocdeData<responseType:Decodable>(data:Data , responseType:responseType.Type)->responseType?{
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(responseType.self, from: data)
            return response
        }catch {
            print ("Error parsing data from json")
            print (error)
            return nil
        }
    }
    
    class func loadImageFromURL(url:URL , handler:@escaping(UIImage? , Error?)->Void){
        let q = DispatchQueue.global()
        q.async {
            do {
                  let data = try Data(contentsOf: url)
                     let image = UIImage(data: data)
                 DispatchQueue.main.async {
                     handler(image , nil )
                 }
            
             }catch {
                 print ("Error in loading the image")
                 DispatchQueue.main.async {
                     handler(nil , error)
                 }
             }
            
        }
        
       
    }
    
    
    class func getImageURL(imageName:String)->URL{
        var  urlStr = EndPoints.images_base_url + "\(imageName)"
        print ("The url str is : \(urlStr)")
        urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
        return URL(string: urlStr)!
    }
}
