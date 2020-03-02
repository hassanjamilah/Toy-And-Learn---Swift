//
//  StoriesListViewController.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class StoriesListViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var storySearchView: UISearchBar!
    @IBOutlet weak var storiesTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var minAge:Int!
    var maxAge:Int!
    var allStories = [Story]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStoriesList()
      }
   
    func loadStoriesList(){
        UIHelper.showIndicator(loadingIndicator: loadingIndicator, show: true)
        ApiClient.searchStory(minAge: minAge, maxAge: maxAge, keyword: "") { (stories, errStr) in
            if let stories = stories {
                self.allStories = stories
                self.storiesTableView.reloadData()
            }else {
                UIHelper.showAlertDialog(message: .errorLodingStoriesList, title: .errorLodingStoriesList, sourceController: self)
            }
            UIHelper.showIndicator(loadingIndicator: self.loadingIndicator, show: false)
        }
    }
}

//MARK: Table View Delegate
extension StoriesListViewController:UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let story = allStories[indexPath.row]
        cell.textLabel?.text = story.storyTitle
        cell.detailTextLabel?.text = story.storyDescription
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toStoryDetails", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? StoryDetailsViewController else {
            return
        }
        guard let row = sender as? Int else {
            return
        }
        controller.story  = allStories[row]
    }
}
