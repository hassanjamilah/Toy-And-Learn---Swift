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
    
    
    fileprivate func setLastSelectedCategory() {
        if let lastSelectedRos = UserDefaults.standard.value(forKey: UserDefaultsKeys.AllKeys.selectedCategory.rawValue) as? Int {
            if lastSelectedRos < categories.count{
                 self.categoriesTableView.selectRow(at: IndexPath(row: lastSelectedRos as! Int, section: 0), animated: true, scrollPosition: .middle)
            }
           
        }
    }
    
    func loadData(){
        UIHelper.showIndicator(loadingIndicator: loadingIndicator, show: true)
        ApiClient.getAllToysCategories { (allCats, errorStr) in
            if let allCats = allCats {
                self.categories = allCats
                DispatchQueue.main.async {
                    self.categoriesTableView.reloadData()
                    self.setLastSelectedCategory()
                }
                
            }else{
                UIHelper.showAlertDialog(message: .errorLaodingCats, title: .errorLoadingCats, sourceController: self)
            }
            UIHelper.showIndicator(loadingIndicator: self.loadingIndicator, show: false)
        }
    }
    
    
    
    
    @IBAction func maxAgeChangedAction(_ sender: Any) {
        maxAgeLabel.text = "\(ToysCategoriesViewController.getSliderIntValue(slider: maxAgeSlider))"
    }
    @IBAction func minAgeChangedAction(_ sender: Any) {
        minAgeLabel.text = "\(ToysCategoriesViewController.getSliderIntValue(slider: minAgeSlider))"
    }
    
    
    /**
     Returns the int value of a slider
     */
    class func getSliderIntValue (slider:UISlider)->Int{
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
         let cell = tableView.dequeueReusableCell(withIdentifier: "catToyCell") as! ToyListTableViewCell
        cell.toyImage.image = nil
        cell.showIndicator()
        if isSearching {
            print("Loading Items from search")
           
            let toy = allToys[indexPath.row]
            cell.toyName.text = toy.toyName
            cell.toyAge.text = "\(toy.toyMinAge) - \(toy.toyMaxAge) Years"
            cell.toyPrice.text = "\(toy.toyPrice)$"
            let imageName = toy.getImagesArray()[0]
            cell.loadImage(imageName: imageName)
            cell.setupForCatToySearch(isFromCat: false)
            return cell
        }else {
           
            
            let category = categories[indexPath.row]
            cell.toyAge.text = category.categoryName
            cell.setupForCatToySearch(isFromCat: true)
            
            cell.loadImage(imageName: category.categoryImageName)
            return cell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSearching{
            performSegue(withIdentifier: "fromCatToToyDetails", sender: indexPath.row)
        }else {
        performSegue(withIdentifier: "toToyList", sender: categories[indexPath.row].categoryID)
        UserDefaults.standard.set(indexPath.row, forKey: UserDefaultsKeys.AllKeys.selectedCategory.rawValue)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? ToysListViewController  {
            guard let catId = sender as? Int else {
                       return
                   }
                   controller.categoyID = catId
        }else if let controller = segue.destination as? ToyDetailsViewController{
            guard let row = sender as? Int else {
                return
            }
            let toy = allToys[row]
            controller.toy = toy
        }
       
        
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
    
    
    func doSearch(word:String ){
        allToys = [Toy]()
        ApiClient.searchToy(categoryID: 0, minAge: ToysCategoriesViewController.getSliderIntValue(slider: minAgeSlider), maxAge: ToysCategoriesViewController.getSliderIntValue(slider: maxAgeSlider), keyword: word) { (toys, errStr) in
            if let toys = toys {
                self.allToys = toys
            }
            self.categoriesTableView.reloadData()
        }
    }
}
