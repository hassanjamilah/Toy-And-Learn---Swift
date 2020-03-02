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
    var isFav = false
    
    var story:Story!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let story = story {
            self.title = story.storyTitle
            
            isFav = StoryDataUtils.checkIfStoryIsInFavorite(storyServerID: Int64(story.storyServerID))
            if isFav {
                setFavButtonIcon(isFavIcon: true)
                
            }else {
                setFavButtonIcon(isFavIcon: false)
            }
        }
        storyWebView.uiDelegate = self
        
        loadPage()
    }
    
    func setFavButtonIcon (isFavIcon:Bool){
        if let favoriteButton = favoriteButton {
            if isFavIcon {
                favoriteButton.image = UIImage(systemName: "star.fill")
            }else {
                favoriteButton.image = UIImage(systemName: "star")
            }
            
            
        }
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
        if isFav {
            StoryDataUtils.addStoryToFavorite(story: story, isFavorite: false)
            isFav = false
            setFavButtonIcon(isFavIcon: false)
        }else {
            StoryDataUtils.addStoryToFavorite(story: story, isFavorite: true)
            isFav = true
            setFavButtonIcon(isFavIcon: true)
        }
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
    }
    
}

extension StoryDetailsViewController:WKUIDelegate{
    
}
