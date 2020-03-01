//
//  MaterialDataExtenstion.swift
//  Toy And Learn
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation
import CoreData

class MaterialDataUtils{
    
    
    
    //MARK: Favorite Operations
    class func addMaterialToFavoritesAndCart( toy:Toy , isFavorit:Bool , isCart:Bool , quantity:Int64?){
        
        if  let material = findMaterialByServerID(id: Int64(toy.toyServerID)){
            material.material_is_favorite = isFavorit
            material.material_is_in_Cart = isCart
            if let quantity = quantity {
                material.material_quantity = quantity
            }
            
        }else {
            let material = setMaterialFromToy(toy: toy)
            
            material.material_is_favorite = isFavorit
            material.material_is_in_Cart = isCart
            if let quantity = quantity {
                material.material_quantity = quantity
            }
        }
        try? DatabaseUtils.shared.context.save()
    }
    
    /**
     Check if the material in  in th favorite to fill the favorite star
     */
    class func checkIfMaterialIsFavorite(material:Materials)->Bool{
        if let material = findMaterialByServerID(id: material.material_server_id) {
            if material.material_is_favorite {
                return true
            }
        }
        return false
    }
    
    /**
     Get all the favorite materials
     */
    class func  getFavoriteMaterials()->[Materials]{
        let predicate = NSPredicate(format: " material_is_favorite = true ")
        let materials = getAllMaterials(predicate: predicate)
        return materials
    }
    
    
    
    //MARK: Cart Methods
    /**
     get All the materials in the cart
     */
    class func getCartMaterials()->[Materials]{
        let predicate = NSPredicate(format: " material_is_in_Cart = true")
        let materials = getAllMaterials(predicate: predicate)
        return materials
    }
    
    class func calculateTheCartValue()->Int64{
        let materials = getCartMaterials()
        var sum:Int64 = 0
        for material in materials {
            sum  += material.material_price * material.material_quantity
        }
        return sum
        
    }
    
    
    
    //MARK: Helper Methods
    class func setMaterialFromToy(toy:Toy)->Materials{
        let material = Materials(context: DatabaseUtils.shared.context)
        material.material_desc = toy.toyDescription
        material.material_images_names = toy.toyImagesString
        material.material_max_age = Int64(toy.toyMaxAge)
        material.material_min_age = Int64(toy.toyMinAge)
        material.material_name = toy.toyName
        material.material_price = Int64(toy.toyPrice)
        material.material_server_id = Int64(toy.toyServerID)
        return material
        
    }
    
    
    
    
    
    
    
    
    
    //MARK: Search Materials Methods
    /**
     Get all the materials from the database
     predicate : used to filter the materials
     */
    class func getAllMaterials(predicate:NSPredicate?)->[Materials]{
        let fetchedReques:NSFetchRequest<Materials> = Materials.fetchRequest()
        let sortDescriptor:NSSortDescriptor = NSSortDescriptor(key: "material_server_id", ascending: true)
        if let predicate = predicate {
            fetchedReques.predicate = predicate
        }
        fetchedReques.sortDescriptors = [sortDescriptor]
        let fetchedResultController:NSFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchedReques, managedObjectContext: DatabaseUtils.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultController.performFetch()
            let materials = fetchedResultController.sections?[0].objects as! [Materials]
            print (materials)
            return materials
        }catch {
            print ("Error getting materials from the database \(error)")
            return []
        }
        
    }
    
    /**
     Used to find a material using it's server id
     */
    class func findMaterialByServerID(id:Int64)->Materials?{
        let predicate = NSPredicate(format: " material_server_id = \(id) ")
        let materials = getAllMaterials(predicate: predicate)
        if materials.count > 0 {
            return materials[0]
        }
        return nil
        
    }
    
    
    
}



