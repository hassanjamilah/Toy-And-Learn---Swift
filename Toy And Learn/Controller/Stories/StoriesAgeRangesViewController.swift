//
//  StoriesAgeRangesViewController.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class StoriesAgeRangesViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var storySearchView: UISearchBar!
    @IBOutlet weak var agesTableView: UITableView!
    
    
    let minAges = [1 , 3 , 5]
    let maxAges = [3 , 5 , 12]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadAges()
    }
    
    
    func loadAges(){
        if let lastSelectedRos = UserDefaults.standard.value(forKey: UserDefaultsKeys.AllKeys.selectedStoryAge.rawValue) as? Int {
            agesTableView.selectRow(at: IndexPath(row: lastSelectedRos, section: 0), animated: true, scrollPosition: .middle)
            
            
        }
    }
    
    
    
}

extension StoriesAgeRangesViewController:UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  minAges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = getCellText(row: indexPath.row)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toStoryList", sender: indexPath.row)
        UserDefaults.standard.set(indexPath.row, forKey: UserDefaultsKeys.AllKeys.selectedStoryAge.rawValue)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? StoriesListViewController else {
            return
        }
        guard let row = sender as? Int else {
            return
        }
        controller.minAge = minAges[row]
        controller.maxAge = maxAges[row]
        
    }
    
    func getCellText(row:Int)->String{
        return "\(minAges[row]) - \(maxAges[row]) Years"
    }
}
