//
//  Order.swift
//  Saffron
//
//  Created by Max Crane on 5/27/16.
//  Copyright © 2016 Saffron Inc. All rights reserved.
//

import Foundation

class Order{
    var id: String
    var customerID: String
    var customerName: String
    var mealID: String
    var mealName: String
    var foodQty: String
    var time: String
    
    init(id: String, customerID: String, custName: String, mealID: String, mealName: String, foodQty: String, time: String){
        self.id = id
        self.customerID = customerID
        self.customerName = custName
        self.mealID = mealID
        self.mealName = mealName
        self.foodQty = foodQty
        self.time = time
    }
}
