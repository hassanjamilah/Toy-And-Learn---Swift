//
//  StoryCoreDataTests.swift
//  StoryCoreDataTests
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import XCTest
@testable import Toy_And_Learn
class StoryCoreDataTests: XCTestCase {
    
    func testInsertStory(){
        let story:Story = Story(storyHtmlURLString: "", storyServerID: 5, storyImageName: "", storyMaxAge: 1, storyMinAge: 20, storyDescription: "Hello", storyTitle: "Hello world")
        let favCountBefore = StoryDataUtils.getFavoriteStories()?.count
        let allStorieCountBefore = StoryDataUtils.getAllStories(predicate: nil)?.count
        StoryDataUtils.addStoryToFavorite(story: story, isFavorite: false)
        let favCountAfter = StoryDataUtils.getFavoriteStories()?.count
        let allStorieCountAfter = StoryDataUtils.getAllStories(predicate: nil)?.count
        
        if favCountAfter == favCountBefore || allStorieCountAfter != allStorieCountBefore{
            XCTFail("Failed in testing adding to favorites")
        }
        debugPrint("fav count before \(favCountBefore) and fav count after \(favCountAfter)" , "all count before \(allStorieCountBefore) all count after \(allStorieCountAfter)" , separator: "🌳🌳🌳🌳🌳🌳🌳", terminator: "\n")
    }
    
    
    
}
