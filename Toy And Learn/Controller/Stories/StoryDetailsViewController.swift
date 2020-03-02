//
//  StoryDetailsViewController.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit
import WebKit
class StoryDetailsViewController: UIViewController  {
    //MARK: Outlets
    
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var storyWebView: WKWebView!
    
   
    var story:Story!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let story = story {
            self.title = story.storyTitle
        }
        
        storyWebView.uiDelegate = self
      
        
        
        loadPage()
    }
    
    func loadPage(){
       
        let url = URL(string: story.storyHtmlURLString)
        
        if let url = url {
            print ("The story url is : \(url)")
            let request = URLRequest(url: url)
            storyWebView.load(request )
        }
        
    }
    
    
    
    @IBAction func addToFavAction(_ sender: Any) {
        StoryDataUtils.addStoryToFavorite(story: story, isFavorite: true)
    }
    
    @IBAction func shareAction(_ sender: Any) {
    }
    
}

extension StoryDetailsViewController:WKUIDelegate{
   
}
