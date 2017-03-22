//
//  Meal.swift
//  Saffron
//
//  Created by Max Crane on 5/27/16 originally as Food.swift
//  Copyright © 2016 Saffron Inc. All rights reserved.
//

import Foundation

class Meal{
    private var name: String
    private var id: String
    private var chefId: String
    private var imageUrl: String
    private var ingredients: String?
    private var price: Double
    private var description: String
    private var shortDesc: String
    
    init(id: String, name: String, chefId: String, url: String, ing: String, price: Double, description: String, shortDesc: String){
        self.id = id
        self.name = name
        self.chefId = chefId
        self.imageUrl = url
        self.ingredients = ing
        self.price = price
        self.description = description
        self.shortDesc = shortDesc
    }
    
    init(id: String, name: String, chefId: String, url: String, price: Double, description: String, shortDesc: String){
        self.id = id
        self.name = name
        self.chefId = chefId
        self.imageUrl = url
        self.price = price
        self.description = description
        self.shortDesc = shortDesc
    }
    
    func getID() -> String {
        return id
    }
    
    func getName() -> String {
        return name
    }
    
    func getChefId() -> String {
        return chefId
    }
    
    func getImageURL() -> String {
        return imageUrl
    }
    
    func getIngredients() -> String? {
        return ingredients
    }
    
    func getPrice() -> Double {
        return price
    }
    func getPriceString() -> String {
        return String(format: "$ %.2f", price)
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getShortDescription() -> String {
        return shortDesc
    }
    
}
