//
//  IDGenerator.swift
//  Saffron
//
//  Created by Erica Solum on 3/3/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import Foundation

enum IDType {
    case meal
    case user
    case order
}

class IDGenerator {
    private static let mealPrefix = "2"
    private static let userPrefix = "0"
    private static let orderPrefix = "1"
    
    private static var nextMealID = 1
    private static var nextUserID = 1
    private static var nextOrderID = 1
    
    
    static func generateMealID() -> String {
        let newID = mealPrefix + String(nextMealID)
        nextMealID = nextMealID + 1
        
        return newID
    }
    
    /*static func generateUserID() -> String {
     nextUserID = FirebaseUtil.getNextUserID()
     let newID = userPrefix + String(nextUserID)
     nextUserID = nextUserID + 1
     
     return newID
     }*/
    
    static func generateOrderID() -> String {
        let newID = orderPrefix + String(nextOrderID)
        return newID
    }
    
    static func getNextUserID() -> Int {
        return nextUserID
    }
}
