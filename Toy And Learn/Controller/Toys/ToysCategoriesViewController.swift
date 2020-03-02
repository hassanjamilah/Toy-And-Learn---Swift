//
//  ToysCategoriesViewController.swift
//  Toy And Learn
//
//  Created by Hassan on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class ToysCategoriesViewController: UIViewController   {
    
    //MARK: Outlets
    @IBOutlet weak var cartButton: UIBarButtonItem!
    @IBOutlet weak var toysSearchView: UISearchBar!
    @IBOutlet weak var minAgeSlider: UISlider!
    @IBOutlet weak var minAgeLabel: UILabel!
    @IBOutlet weak var maxAgeSlider: UISlider!
    @IBOutlet weak var maxAgeLabel: UILabel!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var categories = [Category]()
    var allToys = [Toy]()
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    
    
    func loadData(){
        UIHelper.showIndicator(loadingIndicator: loadingIndicator, show: true)
        ApiClient.getAllToysCategories { (allCats, errorStr) in
            if let allCats = allCats {
                self.categories = allCats
                DispatchQueue.main.async {
                    self.categoriesTableView.reloadData()
                }
                
            }else{
                UIHelper.showAlertDialog(message: .errorLaodingCats, title: .errorLoadingCats, sourceController: self)
            }
            UIHelper.showIndicator(loadingIndicator: self.loadingIndicator, show: false)
        }
    }
    
    
    
    
    @IBAction func maxAgeChangedAction(_ sender: Any) {
        maxAgeLabel.text = "\(getSliderIntValue(slider: maxAgeSlider))"
    }
    @IBAction func minAgeChangedAction(_ sender: Any) {
        minAgeLabel.text = "\(getSliderIntValue(slider: minAgeSlider))"
    }
    
    
    /**
     Returns the int value of a slider
     */
    func getSliderIntValue (slider:UISlider)->Int{
        return Int(slider.value)
    }
    
}

extension ToysCategoriesViewController:UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            print("Loading count from search")
            return allToys.count
        }else {
            return categories.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isSearching {
            print("Loading Items from search")
            let cell = tableView.dequeueReusableCell(withIdentifier: "catToyCell") as! ToyListTableViewCell
            let toy = allToys[indexPath.row]
            cell.toyName.text = toy.toyName
            cell.toyAge.text = "\(toy.toyMinAge) - \(toy.toyMaxAge) Years"
            cell.toyPrice.text = "\(toy.toyPrice)$"
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")!
            
            
            let category = categories[indexPath.row]
            cell.textLabel?.text = category.categoryName
            cell.detailTextLabel?.text = "\(category.categoryID)"
            let url = NetworkHelper.getImageURL(imageName: category.categoryImageName)
            NetworkHelper.loadImageFromURL(url: url) { (image, error) in
                if let image = image {
                    cell.imageView?.image = image
                }
            }
            cell.imageView?.contentMode = .scaleToFill
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "toToyList", sender: categories[indexPath.row].categoryID)
        UserDefaults.standard.set(indexPath.row, forKey: UserDefaultsKeys.AllKeys.selectedCategory.rawValue)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? ToysListViewController else {
            return
        }
        guard let catId = sender as? Int else {
            return
        }
        controller.categoyID = catId
        
    }
}


//MARK: Search View Delegate
extension ToysCategoriesViewController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = true
        if let searchText = searchBar.text{
            
            doSearch(word: searchText)
            toysSearchView.resignFirstResponder()
        }
        
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        toysSearchView.resignFirstResponder()
        loadData()
    }
    
    
    func doSearch(word:String){
        ApiClient.searchToy(categoryID: 0, minAge: getSliderIntValue(slider: minAgeSlider), maxAge: getSliderIntValue(slider: maxAgeSlider), keyword: word) { (toys, errStr) in
            if let toys = toys {
                self.allToys = toys
            }
            self.categoriesTableView.reloadData()
        }
    }
}
