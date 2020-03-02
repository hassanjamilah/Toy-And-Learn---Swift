//
//  FavoritesTableViewController.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    @IBOutlet weak var favoritTableView: UITableView!
    var allStories = [Stories]()
    var allToys = [Materials]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavorites()
    }
    
    func loadFavorites(){
        if let stories = StoryDataUtils.getFavoriteStories(){
            allStories = stories
            
        }
        if let toys = MaterialDataUtils.getFavoriteMaterials() {
            allToys = toys
        }
        favoritTableView.reloadData()
    }
    
    
    
    
    
    
}

extension FavoritesTableViewController:UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
   
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Favorite Toys"
        case 1 :
            return "Favorite Stories"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return allToys.count
        }else if section == 1 {
            return allStories.count
        }else {
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch  indexPath.section {
        case 0:
            let toy = allToys[indexPath.row]
            cell.textLabel?.text = toy.material_name
            return cell
        case 1 :
            let story = allStories[indexPath.row]
            cell.textLabel?.text = story.story_title
            return cell
        default:
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var segId = ""
        switch indexPath.section {
        case 0:
            segId = ""
        case 1 :
            segId = ""
        default:
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ToyDetailsViewController {
            
        }else if let controller = segue.destination as? StoryDetailsViewController {
            
        }
    }
}
