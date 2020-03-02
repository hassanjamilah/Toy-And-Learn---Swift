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
    
    var categories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    
    
    func loadData(){
        ApiClient.getAllToysCategories { (allCats, errorStr) in
            if let allCats = allCats {
                self.categories = allCats
                DispatchQueue.main.async {
                    self.categoriesTableView.reloadData()
                }
              
            }else{
                UIHelper.showAlertDialog(message: .errorLaodingCats, title: .errorLoadingCats, sourceController: self)
            }
            
        }
    }
    
    
}

extension ToysCategoriesViewController:UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell")!
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.categoryName + "\(category.categoryID)"
        cell.detailTextLabel?.text = "\(category.categoryID)"
       // let url = NetworkHelper.getImageURL(imageName: category.categoryImageName)
        /*NetworkHelper.loadImageFromURL(url: url) { (image, error) in
            if let image = image {
                cell.imageView?.image = image
            }
        }*/
        //cell.imageView?.contentMode = .scaleToFill
        return cell
         
        
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
