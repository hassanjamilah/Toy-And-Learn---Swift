//
//  ToysListViewController.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class ToysListViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var toySearchView: UISearchBar!
    @IBOutlet weak var minAgeSlider: UISlider!
    @IBOutlet weak var minAgeLabel: UILabel!
    @IBOutlet weak var maxAgeSlider: UISlider!
    @IBOutlet weak var maxAgeLabel: UILabel!
    @IBOutlet weak var cartButton: UIBarButtonItem!
    @IBOutlet weak var toysTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
   
    
    var categoyID:Int!
    var allToys = [Toy]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        
    }
    
    func loadData(){
        UIHelper.showIndicator(loadingIndicator: loadingIndicator, show: true)
        
        ApiClient.searchToy(categoryID: categoyID, minAge: 1, maxAge: 20, keyword: "") { (toys, errorStr) in
            if let toys = toys {
                self.allToys = toys
                self.toysTableView.reloadData()
            }else {
                UIHelper.showAlertDialog(message: .errorLodingToysList, title: .errorLodingToysList, sourceController: self)
            }
            UIHelper.showIndicator(loadingIndicator: self.loadingIndicator, show: false)
            
        }
    }
    
    


}


extension ToysListViewController:UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allToys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "toyListCell") as! ToyListTableViewCell
        let toy = allToys[indexPath.row]
        cell.toyName.text  = toy.toyName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let toy = allToys[indexPath.row]
        performSegue(withIdentifier: "toToyDetails", sender: toy)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? ToyDetailsViewController else {
            return
        }
        guard let toy = sender as? Toy else {
            return
        }
        controller.toy = toy
        
        
    }
    
    
}
