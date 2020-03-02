//
//  CodableTests.swift
//  CodableTests
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import XCTest
@testable import Toy_And_Learn
class CodableTests: XCTestCase {
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    //MARK: Categories Struct Test
    func testCategoriesStruct(){
        do {
            let result = try JSONDecoder().decode(AllCats.self, from: SampleData.categoriesJsonSample)
            print ("The result is : \(result) ")
        }catch {
            print ("The error in json parsing is : \(error)")
            XCTFail("Error parsing the json data")
        }
    }
    
    //MARK: Toys Struct Test
    func testToysStruct (){
        do{
            let result = try JSONDecoder().decode(AllToys.self, from: SampleData.toysJsonSample)
            print (result )
        }catch{
            print ("Error parsing json data : \(error)")
            XCTFail("Error parsing json data \(error)")
        }
    }
    
    
    //MARK: Stories Struct Test
    func testStoriesStruct(){
        do{
            let result = try JSONDecoder().decode(AllStories.self, from: SampleData.storyJsonSampleData)
            print (result )
        }catch{
            print ("Error parsing json data : \(error)")
            XCTFail("Error parsing json data \(error)")
        }
    }

    enum SampleData{
      
        static let categoriesJsonSample = """
         {
             "categories": [{
                 "catId": 1,
                 "catName": "Animals",
                 "catDesc": "",
                 "catNotes": "",
                 "catImageName": "animals.jpg"
             }]
         }
         """.data(using: .utf8)!
        
        
        static let toysJsonSample = """
            {
               "toys":[{
                   "Toy_Age_Max": 6,
                   "Toy_Age_Min": 3,
                   "Toy_CatID": 1,
                   "Toy_Desc": "Hello ",
                   "Toy_ID": 1,
                   "Toy_Images_Names": "Animals1.jpg",
                   "Toy_Name": "SCS Direct Farm Animal Toys Action",
                   "Toy_Notes": "",
                   "Toy_Price": 20
              }]
            }
        """.data(using: .utf8)!
        
        
        static let storyJsonSampleData = """
        {
        "stories": [
            {
                "Story_Html_Url": "http://www.magickeys.com/books/gingerbread/index.html",
                "Story_ID": 1,
                "Story_Image_Name": "story001.gif",
                "Story_Max_Age": 3,
                "Story_Min_Age": 1,
                "Story_Min_Desc": "by Carol Moore - A surprising new version of the classic Gingerbread Man fairy tale.",
                "Story_Notes": "",
                "Story_Title": "The Little Gingerbread Man"
            },
            {
                "Story_Html_Url": "http://www.magickeys.com/books/noblegnarble/index.html",
                "Story_ID": 2,
                "Story_Image_Name": "story002.gif",
                "Story_Max_Age": 3,
                "Story_Min_Age": 1,
                "Story_Min_Desc": "y Daniel Errico - Illustrated by Christian Colabelli - Deep below the ocean waves a gnarble fish dreams of seeing the sun and sky. Also available at Amazon in hardcover and Kindle editions.",
                "Story_Notes": "",
                "Story_Title": "The Journey of the Noble Gnarble "
            },
            {
                "Story_Html_Url": "http://www.magickeys.com/books/invis-allig/index.html",
                "Story_ID": 3,
                "Story_Image_Name": "story003.gif",
                "Story_Max_Age": 3,
                "Story_Min_Age": 1,
                "Story_Min_Desc": "by Hayes Roberts - Little Sari discovers invisible alligators quietly sneaking around creating trouble for her and everyone else.",
                "Story_Notes": "",
                "Story_Title": "Invisible Alligators"
            }
        ]}
        """.data(using: .utf8)!
    }


}
