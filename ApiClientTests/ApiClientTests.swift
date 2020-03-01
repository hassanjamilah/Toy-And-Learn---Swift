//
//  ApiClientTests.swift
//  ApiClientTests
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import XCTest
@testable import Toy_And_Learn
class ApiClientTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    
    //MARK: Get Categories Test
    func testForGetAllCategories (){
        let promise = expectation(description: "Got categories successfully")
       
            ApiClient.getAllToysCategories { (categories, errorStr) in
                if let categories = categories {
                    print (categories)
                    promise.fulfill()
                }else {
                    XCTFail("Error getting categories")
                }
            }
       
        wait(for: [promise], timeout: 5)
    }
    
    //MARK: Get Toys Test
    func testGetToys(){
        let promise = expectation(description: "Got toys scuccessfully")
        ApiClient.searchToy(categoryID: 1, minAge: 1, maxAge: 20, keyword: "a") { (toys, error) in
            if let toys = toys {
                print (toys)
                promise.fulfill()
            }else {
                print (error)
                XCTFail("Error getting the toys : \(error)")
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
    
    //MARK: Get Stories Test
    func testGetStories (){
        let promise = expectation(description: "Got Stories successfully")
        ApiClient.searchStory(minAge: 1, maxAge: 20, keyword: "a") { (stories, error) in
            if let stories = stories {
                print (stories)
                promise.fulfill()
            }else {
                print (error)
                XCTFail("Error getting stories : \(error)")
                
            }
        }
        wait(for: [promise], timeout: 5)
    }
    
}
