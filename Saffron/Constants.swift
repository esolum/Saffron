//
//  Constants.swift
//  Saffron
//
//  Created by Erica Solum on 3/3/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import Foundation

struct Constants {
    
    struct OrderFields {
        static let customerID = "customerID"
        static let customerName = "customerName"
        static let mealID = "mealID"
        static let mealName = "mealName"
        static let quantity = "quantity"
        static let time = "time"
    }
    
    struct UserFields {
        static let username = "username"
        static let name = "name"
        static let isChef = "isChef"
        static let email = "email"
    }
    
    struct MealFields {
        static let chefID = "chefID"
        static let imgURL = "imgURL"
        static let ingredients = "ingredients"
        static let name = "name"
        static let price = "price"
        static let description = "description"
        static let shortDesc = "short_desc"
    }
}
