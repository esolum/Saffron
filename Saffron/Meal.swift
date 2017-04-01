//
//  Meal.swift
//  Saffron
//
//  Created by Max Crane on 5/27/16 originally as Food.swift
//  Copyright © 2016 Saffron Inc. All rights reserved.
//

import Foundation
import Validator

enum ServingType {
    case slice
    case cup
    case plate
    case other
    case scoop
    
}

class Meal {
    private var name: String
    private var id: String
    private var chefId: String
    private var imageUrl: String
    private var ingredients: String?
    private var price: Double
    private var description: String
    private var shortDesc: String
    private var servingType: String
    private var date: Date
    
    
    init(id: String, name: String, chefId: String, url: String, ing: String, price: Double, description: String, shortDesc: String, servingType: String, date: Date){
        self.id = id
        self.name = name
        self.chefId = chefId
        self.imageUrl = url
        self.ingredients = ing
        self.price = price
        self.description = description
        self.shortDesc = shortDesc
        self.servingType = servingType
        self.date = date
    }
    
    init(id: String, name: String, chefId: String, url: String, price: Double, description: String, shortDesc: String, servingType: String, date: Date){
        self.id = id
        self.name = name
        self.chefId = chefId
        self.imageUrl = url
        self.price = price
        self.description = description
        self.shortDesc = shortDesc
        self.servingType = servingType
        self.date = date
    }
    
    init() {
        self.id = ""
        self.name = ""
        self.chefId = ""
        self.imageUrl = ""
        self.ingredients = ""
        self.price = 0.0
        self.description = ""
        self.shortDesc = ""
        self.servingType = ""
        self.date = Date()
    }
    
    /* Set functions */
    func setMealID(id: String) {
        self.id = id
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setChefID(id: String) {
        self.chefId = id
    }
    
    func setImageURL(url: String) {
        self.imageUrl = url
    }
    
    func setIngredients(ing: String) {
        self.ingredients = ing
    }
    
    func setPrice(price: Double) {
        self.price = price
    }
    
    func setDescription(desc: String) {
        self.description = desc
    }
    
    func setShortDescription(shortDesc: String) {
        self.shortDesc = shortDesc
    }
    
    func setServingType(type: String) {
        self.servingType = type
    }
    
    func setDate(date: Date) {
        self.date = date
    }
    
    /* Get functions */
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
    
    func getServingType() -> String {
        return servingType
    }
    
    func getDate() -> Date {
        return date
    }
    
    func getDateAsString() -> String {
        return MealUtils.stringFromDate(date: date, format: "yyyy-MM-ddTHH:mm:ssZ")
    }
    
    
    
}
