//
//  CoreDataTests.swift
//  CoreDataTests
//
//  Created by user on 01/03/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import XCTest
@testable import Toy_And_Learn
class CoreDataTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: Insert Material Test
    func testInsertMaterial (){
        let material = Materials(context: DatabaseUtils.shared.context)
        material.material_name = "hassan"
        material.material_server_id = 5
        try? DatabaseUtils.shared.context.save()
    }
    
   
    //MARK: Get All Database Materials Test
    func testGetAllMaterials (){
        let result = MaterialDataUtils.getAllMaterials(predicate: nil )
        if result.count == 0 {
            XCTFail("Faild getting the materials ")
        }
        print ("🤴 The result count is : \(result.count)")
    }

   //MARK: Test Get Material By ID
    func testGetMaterialByID(){
        if let material = MaterialDataUtils.findMaterialByServerID(id: 5){
            print (material)
        }else {
            XCTFail("Can not find material ")
        }
        
    }
    
    //MARK: Test Add to Favorite for existing material
    /**
     You can do this test only once and than change the favorite to the opposite value
     */
    func testAddToFavoriteForExisting(){
        let toy = Toy(toyMaxAge: 20, toyMinAge: 1, toyCategoryID: 1, toyDescription: "", toyServerID: 5, toyImagesString: "", toyName: "hassan", toyPrice: 15)
        
       
        let beforeCount = MaterialDataUtils.getFavoriteMaterials().count
        let allMatsBeforeCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
        MaterialDataUtils.addMaterialToFavoritesAndCart(toy: toy, isFavorit: true, isCart: false, quantity: nil)
        let afterCount = MaterialDataUtils.getFavoriteMaterials().count
        let allMatsAfterCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
        if beforeCount == afterCount || allMatsBeforeCount != allMatsAfterCount {
            XCTFail("The add material to favorite failed")
        }
        debugPrint("Fav count befor : \(beforeCount) and Fav count after : \(afterCount)" ,
        "All Mats count before : \(allMatsBeforeCount)  and all Mats count after : \(allMatsAfterCount)"
            , separator: "🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️", terminator: "\n"
            
        )
       
    }
    
    //MARK: Test Add to Favorite for Not existing material
    func testAddToFavoriteForNotExisting(){
        let x = Int.random(in: 1...10000)
        var toy = Toy(toyMaxAge: 20, toyMinAge: 1, toyCategoryID: 1, toyDescription: "", toyServerID: x, toyImagesString: "", toyName: "hassan", toyPrice: 15)
        
               let beforeCount = MaterialDataUtils.getFavoriteMaterials().count
               let allMatsBeforeCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
        MaterialDataUtils.addMaterialToFavoritesAndCart(toy: toy, isFavorit: true, isCart: false, quantity: nil )
               let afterCount = MaterialDataUtils.getFavoriteMaterials().count
               let allMatsAfterCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
               if beforeCount == afterCount || allMatsBeforeCount == allMatsAfterCount {
                  // XCTFail("The add material to favorite failed")
               }
               debugPrint("Fav count befor : \(beforeCount) and Fav count after : \(afterCount)" ,
               "All Mats count before : \(allMatsBeforeCount)  and all Mats count after : \(allMatsAfterCount)"
                   , separator: "🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️", terminator: "\n"
                   
               )
    }
    
    
    //MARK: Test Add to Cart for existing material
    /**
     You can do this test only once and than change the favorite to the opposite value
     */
    func testAddToCartForExisting(){
        let toy = Toy(toyMaxAge: 20, toyMinAge: 1, toyCategoryID: 1, toyDescription: "", toyServerID: 5, toyImagesString: "", toyName: "hassan", toyPrice: 15)
        
       
        let beforeCount = MaterialDataUtils.getCartMaterials().count
        let allMatsBeforeCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
        MaterialDataUtils.addMaterialToFavoritesAndCart(toy: toy, isFavorit: false, isCart: true, quantity: 10)
        let afterCount = MaterialDataUtils.getCartMaterials().count
        let allMatsAfterCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
        if beforeCount == afterCount || allMatsBeforeCount != allMatsAfterCount {
            XCTFail("The add material to Cart failed")
        }
        debugPrint("Cart count befor : \(beforeCount) and Cart count after : \(afterCount)" ,
        "All Mats count before : \(allMatsBeforeCount)  and all Mats count after : \(allMatsAfterCount)"
            , separator: "🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️", terminator: "\n"
            
        )
       
    }
    
    //MARK: Test Add to Cart for Not existing material
    func testAddToCartForNotExisting(){
        let x = Int.random(in: 1...10000)
        var toy = Toy(toyMaxAge: 20, toyMinAge: 1, toyCategoryID: 1, toyDescription: "", toyServerID: x, toyImagesString: "", toyName: "hassan", toyPrice: 15)
        
        let beforeCount = MaterialDataUtils.getCartMaterials().count
               let allMatsBeforeCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
        MaterialDataUtils.addMaterialToFavoritesAndCart(toy: toy, isFavorit: true, isCart: true, quantity: 10 )
        let afterCount = MaterialDataUtils.getCartMaterials().count
               let allMatsAfterCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
               if beforeCount == afterCount || allMatsBeforeCount == allMatsAfterCount {
                  // XCTFail("The add material to favorite failed")
               }
               debugPrint("Cart count befor : \(beforeCount) and Cart count after : \(afterCount)" ,
               "All Mats count before : \(allMatsBeforeCount)  and all Mats count after : \(allMatsAfterCount)"
                   , separator: "🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️", terminator: "\n"
                   
               )
    }
    
    
    
    func testUpdateMaterial (){
        if  let material = MaterialDataUtils.findMaterialByServerID(id: 5) {
            let allMatsBeforeCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
                   material.material_is_favorite = false
            material.material_is_in_Cart = false
                   try? DatabaseUtils.shared.context.save()
                   let allMatsAfterCount = MaterialDataUtils.getAllMaterials(predicate: nil).count
                   debugPrint(
                                "🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️ All Mats count before : \(allMatsBeforeCount)  and all Mats count after : \(allMatsAfterCount)"
                                    , separator: "🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️🚴‍♀️", terminator: "\n"
                                    
                                )
        }
       
    }
    
    
    
    //MARK: Test if material is in favorite
    func testIfMaterialIsInFavorite(){
        let material = Materials(context: DatabaseUtils.shared.context)
        material.material_server_id = 5
        if MaterialDataUtils.checkIfMaterialIsFavorite(material: material){
            print ("🦋🦋🦋🦋🦋🦋🦋🦋🦋")
        }else {
            XCTFail("Failure in testing : The material is in favorite")
        }
    }
    
}
