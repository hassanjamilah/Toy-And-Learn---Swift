//
//  CartViewController.swift
//  Toy And Learn
//
//  Created by user on 02/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var cartTotalLabel: UILabel!
    @IBOutlet weak var emptyCartButton: UIButton!
    
    var allToys = [Materials]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.separatorStyle = .singleLine
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCart()
    }
    
    func loadCart(){
        if let toys = MaterialDataUtils.getCartMaterials(){
            allToys = toys
        }
        let total = MaterialDataUtils.calculateTheCartValue()
        cartTotalLabel.text = "\(total)"
    }
    
    @IBAction func emptyCartAction(_ sender: Any) {
        MaterialDataUtils.emptyCart()
        allToys = [Materials]()
        cartTableView.reloadData()
        cartTotalLabel.text = "0"
    }
    

}

extension CartViewController:UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allToys.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCellID") as! CartTableViewCell
        let toy = allToys[indexPath.row]
        cell.toyNameLabel.text = toy.material_name
        cell.toyPriceLabel.text = "\(toy.material_price)"
        cell.toyQuantityLabel.text = "\(toy.material_quantity)"
        let totalForCell = toy.material_price * toy.material_quantity
        cell.toyTotalLabel.text = "\(totalForCell)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toy = MaterialDataUtils.setToyFromMaterial(material: allToys[indexPath.row])
            let isFav = MaterialDataUtils.checkIfMaterialIsFavorite(serverID: toy.toyServerID)
            MaterialDataUtils.addMaterialToFavoritesAndCart(toy: toy, isFavorit: isFav , isCart: false, quantity: 0)
            allToys.remove(at: indexPath.row)
            cartTableView.reloadData()
            let total = MaterialDataUtils.calculateTheCartValue()
            cartTotalLabel.text = "\(total)"
            
        }
    }
}
