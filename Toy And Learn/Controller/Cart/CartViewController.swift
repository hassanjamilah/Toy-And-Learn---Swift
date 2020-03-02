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
}
