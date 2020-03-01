//
//  StoryDataUtils.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation
import CoreData
class StoryDataUtils{
    class func addStoryToFavorite(story:Story , isFavorite:Bool){
        if let story = getStoryByServerID(storyServerId: Int64(story.storyServerID)){
            story.story_isFavorite = isFavorite
        }else {
            let story = getStoryFromStoryResponse(storyResp: story)
            story.story_isFavorite = isFavorite
        }
        try? DatabaseUtils.shared.context.save()
    }
    
    class func getStoryFromStoryResponse(storyResp:Story)->Stories{
        let story:Stories = Stories(context: DatabaseUtils.shared.context)
        story.story_desc  = storyResp.storyDescription
        story.story_id = Int64(storyResp.storyServerID)
        story.story_image_name = storyResp.storyImageName
        story.story_title  = storyResp.storyTitle
        story.story_url = storyResp.storyHtmlURLString
        return story
    }
    
    class func getAllStories (predicate:NSPredicate?)->[Stories]?{
        let fetchReqeust:NSFetchRequest<Stories> = Stories.fetchRequest()
        if let predicate = predicate {
            fetchReqeust.predicate = predicate
        }
        let sortDescriptor = NSSortDescriptor(key: "story_id", ascending: true)
        fetchReqeust.sortDescriptors = [sortDescriptor]
        let fetchedResultController:NSFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchReqeust, managedObjectContext: DatabaseUtils.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultController.performFetch()
            let stories = fetchedResultController.sections?[0].objects as! [Stories]
            return stories
        }catch {
            print ("Error getting the stories from the database \(error)")
            return nil
        }
    }
    
    class func getFavoriteStories()->[Stories]?{
        let predicate = NSPredicate(format: " story_isFavorite = true ")
        if let stories = getAllStories(predicate: predicate){
            return stories
        }else {
            return nil
        }
    }
    
    class func getStoryByServerID(storyServerId:Int64)->Stories?{
        let predicate = NSPredicate(format: " story_id = \(storyServerId) ")
        if let stories = getAllStories(predicate: predicate){
            if stories.count > 0 {
                
                return stories[0]
            }
        }
            return nil
        
    }
    
    class func checkIfStoryIsInFavorite(storyServerID:Int64)->Bool{
        if let story = getStoryByServerID(storyServerId: storyServerID){
            if story.story_isFavorite {
                return true
            }
        }
        return false
    }
}
