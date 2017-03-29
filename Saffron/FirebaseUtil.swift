//
//  FirebaseUtil.swift
//  Saffron
//
//  Created by Erica Solum on 3/3/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//
//  FirebaseUtil contains all functions to read/write date to/from the database.
//  Also contains an extension to the String class for converting Strings to Bools.
//

import Foundation
import Firebase
import DKImagePickerController

class FirebaseUtil {
    static let url = "https://blazing-heat-9131.firebaseio.com/"
    static let urluser = "https://blazing-heat-9131.firebaseio.com/users"
    static let urlorder = "https://blazing-heat-9131.firebaseio.com/orders"
    
    //static var fb: Firebase?
    //static var fbUser: Firebase?
    //static var fbOrder: Firebase?
    
    static var ref: FIRDatabaseReference!
    static var mealContentChanged = false
    static var orderContentChanged = false
    
    static var userName: String?
    static var orders: [Order]?
    //static var foods: [Food]?
    static var meals: [Meal]?
    static var users: [User]?
    //static var foodMap: [String: Food]?
    static var mealMap: [String: Meal]?
    
    static var orderData: [FIRDataSnapshot]! = []
    static var userData: [FIRDataSnapshot]! = []
    static var mealData: [FIRDataSnapshot]! = []
    static fileprivate var _refHandle: FIRDatabaseHandle!
    static var storage: FIRStorage!
    static var storageRef: FIRStorageReference!
    static var imagesRef: FIRStorageReference!
    static var mealImagesRef: FIRStorageReference!
    
    
    //Attaches the listeners to the Firebase database lists
    //Called in AppDelegate.swift
    static func configureDatabase() {
        self.ref = FIRDatabase.database().reference()
        
        //Make meal map
        mealMap = [String: Meal]()
        
        // Listen for new orders in the Firebase database
        _refHandle = self.ref.child("orders").observe(.childAdded, with: { (snapshot) -> Void in
            //guard let strongSelf = self else { return }
            //strongSelf.orderData.append(snapshot)
            orderData.append(snapshot)
            orderContentChanged = true
            
            // Unpack order from Firebase DataSnapshot
            let orderSnapshot: FIRDataSnapshot! = snapshot
            guard let order = orderSnapshot.value as? [String:String] else { return }
            let mealName = order[Constants.OrderFields.mealName] ?? ""
            let customerID = order[Constants.OrderFields.customerID] ?? ""
            let customerName = order[Constants.OrderFields.customerName] ?? ""
            let mealID = order[Constants.OrderFields.mealID] ?? ""
            let quantity = order[Constants.OrderFields.quantity] ?? ""
            let time = order[Constants.OrderFields.time] ?? ""
            
            let newOrder = Order(id: IDGenerator.generateOrderID(), customerID: customerID, custName: customerName, mealID: mealID, mealName: mealName, foodQty: quantity, time: time)
            orders?.append(newOrder)
            
        })
        
        // Listen for new users in the Firebase database.
        // Can't think when I will use this but keeping it commented for the future
        /*_refHandle = self.ref.child("users").observe(.childAdded, with: { (snapshot) -> Void in
         userData.append(snapshot)
         
         // Unpack user from Firebase DataSnapshot
         let userSnapshot: FIRDataSnapshot! = snapshot
         guard let user = userSnapshot.value as? [String:String] else { return }
         let name = user[Constants.UserFields.name] ?? ""
         let username = user[Constants.UserFields.username] ?? ""
         let isChef = user[Constants.UserFields.isChef]?.toBool() ?? false
         let email = user[Constants.UserFields.email] ?? ""
         
         let newUser = User(id: IDGenerator.generateUserID(), username: username, name: name, isChef: isChef, email: email)
         users?.append(newUser)
         
         })*/
        
        // Listen for new meals in the Firebase database
        _refHandle = self.ref.child("meals").observe(.childAdded, with: { (snapshot) -> Void in
            //guard let strongSelf = self else { return }
            //strongSelf.orderData.append(snapshot)
            mealData.append(snapshot)
            //print("New meal is coming!")
            mealContentChanged = true
            
            // Unpack meal from Firebase DataSnapshot
            let mealSnapshot: FIRDataSnapshot! = snapshot
            guard let meal = mealSnapshot.value as? [String:String] else { return }
            let chefID = meal[Constants.MealFields.chefID] ?? ""
            let imgURL = meal[Constants.MealFields.imgURL] ?? ""
            let name = meal[Constants.MealFields.name] ?? ""
            let price = Double(meal[Constants.MealFields.price]!) ?? -1.0
            let description = meal[Constants.MealFields.description] ?? ""
            let shortDesc = meal[Constants.MealFields.shortDesc] ?? ""
            let servingType = meal[Constants.MealFields.servingType] ?? "other"
            let dateString = meal[Constants.MealFields.date] ?? ""
            let date = MealUtils.dateFromString(dateStr: dateString)
            
            
            if let ingredients = meal[Constants.MealFields.ingredients] {
                let newMeal = Meal(id: IDGenerator.generateMealID(), name: name, chefId: chefID, url: imgURL, ing: ingredients, price: price, description: description, shortDesc: shortDesc, servingType: servingType, date: date)
                meals?.append(newMeal)
                mealMap![newMeal.getID()] = newMeal
            } else {
                let newMeal = Meal(id: IDGenerator.generateMealID(), name: name, chefId: chefID, url: imgURL, price: price, description: description, shortDesc: shortDesc, servingType: servingType, date: date)
                meals?.append(newMeal)
                mealMap![newMeal.getID()] = newMeal
            }
            
        })
    }
    
    //Configures Firebase storage references - called in AppDelegate
    static func configureStorage() {
        // Get a reference to the storage service using the default Firebase App
        storage = FIRStorage.storage()
        // Create a storage reference from our storage service
        storageRef = storage.reference()
        
        // Create a child reference
        // imagesRef now points to "images"
        imagesRef = storageRef.child("images")
        
        mealImagesRef = imagesRef.child("meals")
        
    }
    
    // Get list of users
    static func getUsers() -> [User] {
        return users!
    }
    
    // Get list of meals
    static func getMeals(_ handler: @escaping ([Meal])->()){
        if(meals != nil && !mealContentChanged){
            handler(meals!)
        }
        else {
            //TODO: Handle this later to read and convert meal snapshot once
            //let userID = FIRAuth.auth()?.currentUser?.uid
            
            let mealsList = ref.child("meals").observeSingleEvent(of: .value, with: { (snapshot) -> Void in
                meals = [Meal]()
                mealMap = [String: Meal]()
                let enumerator = snapshot.children
                
                //while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                
                //                }
                //
                //                for child in snapshot.children {
                for child in snapshot.children {
                    let snap = child as! FIRDataSnapshot
                    let childSnapshot = snapshot.childSnapshot(forPath: snap.key)
                    let vals = childSnapshot.value as! NSDictionary
                    let name = vals[Constants.MealFields.name] as! String
                    let chefID = vals[Constants.MealFields.chefID] as! String
                    let imageUrl = vals[Constants.MealFields.imgURL] as! String
                    let price = vals[Constants.MealFields.price] as! Double
                    let description = vals[Constants.MealFields.description] as! String
                    let shortDesc = vals[Constants.MealFields.shortDesc] as! String
                    let servingType = vals[Constants.MealFields.servingType] as! String
                    let date = vals[Constants.MealFields.date] as! Date
                    
                    var newMeal: Meal
                    
                    if (vals[Constants.MealFields.ingredients] != nil){
                        let ing = vals[Constants.MealFields.ingredients] as! String
                        newMeal = Meal(id: IDGenerator.generateMealID(), name: name, chefId: chefID, url: imageUrl, ing: ing, price: price, description: description, shortDesc: shortDesc, servingType: servingType, date: date)
                    }
                    else {
                        newMeal = Meal(id: IDGenerator.generateMealID(), name: name, chefId: chefID, url: imageUrl, price: price, description: description, shortDesc: shortDesc, servingType: servingType, date: date)
                    }
                    
                    
                    
                    meals!.append(newMeal)
                    mealMap![newMeal.getID()] = newMeal
                }
                
                handler(meals!)
                
            })
            
            mealContentChanged = false
        }
        
    }
    
    // Get list of orders
    static func getOrders(_ handler: @escaping ([Order]) ->()) {
        if orders != nil && !orderContentChanged{
            handler(orders!)
        }
        else {
            //TODO: Handle this later to read and convert order snapshot once
        }
    }
    
    static func getMealById(_ id: String)->Meal?{
        if(mealMap != nil){
            if let theMeal = mealMap![id]{
                return theMeal
            }
            else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    //Get the next user ID from the database so new user is created with correct ID
    static func getNextUserID() -> Int{
        var newVal = -1
        ref.child("nextUserID").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? Int ?? -1
            newVal = value
            
        }) { (error) in
            print(error.localizedDescription)
        }
        return newVal
    }
    
    //Update the next user ID in the database
    static func updateNextUserID(){
        self.ref.child("nextUserID").setValue(IDGenerator.getNextUserID())
        
    }
    
    //Get user data for current user or nil if user is not signed in
    static func getCurrentUserData() -> FIRUser? {
        return FIRAuth.auth()?.currentUser
    }
    
    
    //MARK: Upload Functions
    
    // Upload new meal to Firebase
    static func submitNewMeal(meal: Meal, assets: [DKAsset]) -> Bool {
        
        // Create reference to folder containing this meal's images with id
        let newMealRef = mealImagesRef.child("\(meal.getID())")
        
        // Create a reference to primary image
        let primaryRef = newMealRef.child("0.png")
        
        
        
        
        
        let primaryAsset = assets[0]
        primaryAsset.fetchOriginalImage(false, completeBlock: {
            image, info in
            let data = UIImagePNGRepresentation(image!)
            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = primaryRef.put(data, metadata: nil) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return false
                }
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata.downloadURL
                meal.setImageURL(url: downloadURL)
            }
            
        })
        
        return true
    }
    
    /*static func getFBUsers()->Firebase{
     if(fbUser != nil){
     return fbUser!
     }
     else{
     fbUser = Firebase(url: urluser)
     return fbUser!
     }
     }
     
     static func getFBOrders()->Firebase{
     if(fbOrder != nil){
     return fbOrder!
     }
     else{
     fbOrder = Firebase(url: urlorder)
     return fbOrder!
     }
     }*/
    
    /*static func getUsersName(_ handler: @escaping (String)->()){
     if userName != nil{
     handler(userName!)
     }
     else{
     let fb = Firebase(url: "https://blazing-heat-9131.firebaseio.com/users/" + self.getFB().authData.uid)
     fb.observeEventType(.Value, withBlock: {
     snapshot in
     
     if let name = snapshot.value.valueForKey("name") as? String{
     self.userName = name
     handler(userName!)
     }else{
     handler("")
     }
     
     })
     }
     }*/
    
    /*static func getUserName(handler: @escaping (String)->()) {
     if userName != nil{
     handler(userName!)
     }
     else {
     
     }
     }*/
    
    /*static func loadOrders(handler: @escaping ([Order])->()){
     let userID = FIRAuth.auth()?.currentUser?.uid
     ref.child("orders").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
     // Get user value
     let value = snapshot.value as? NSDictionary
     let username = value?["username"] as? String ?? ""
     let user = User.init(username: username)
     
     // ...
     }) { (error) in
     print(error.localizedDescription)
     }
     }*/
    
    /*static func loadOrders(_ handler: @escaping ([Order])->()){
     let fb = Firebase(url: urlorder + "/" + self.getFB().authData.uid)
     
     
     fb.observeSingleEventOfType(.Value, withBlock: { snapshot in
     print(snapshot.childrenCount) // I got the expected number of items
     var orders = [Order]()
     for rest in snapshot.children.allObjects as! [FDataSnapshot] {
     
     
     var customerName = ""
     if (rest.value.valueForKey("customerName") != nil){
     customerName = (rest.value.valueForKey("customerName") as? String)!
     }
     
     var foodId = ""
     if (rest.value.valueForKey("food0Id") != nil){
     foodId = (rest.value.valueForKey("food0Id") as? String)!
     }
     
     var foodQty = ""
     if (rest.value.valueForKey("food0Qty") != nil){
     foodQty = (rest.value.valueForKey("food0Qty") as? String)!
     }
     
     var time = ""
     if (rest.value.valueForKey("time") != nil){
     time = (rest.value.valueForKey("time") as? String)!
     }
     
     orders.append(Order(custName: customerName, food: foodId, foodQty: foodQty, time: time))
     
     
     }
     
     handler(orders)
     })
     }*/
    
    /*
     static func loadFoods(_ handler: @escaping ([Food])->()){
     if(foods != nil){
     handler(foods!)
     }
     else{
     self.getFB().childByAppendingPath("foods").observeSingleEventOfType(
     FEventType.Value, withBlock: { (snapshot) -> Void in
     foods = [Food]()
     foodMap = [String: Food]()
     
     for child in snapshot.children {
     
     let childSnapshot = snapshot.childSnapshotForPath(child.key)
     let someValue = childSnapshot.value["foodName"] as! String
     let chef = childSnapshot.value["chefid"] as! String
     let someImageUrl = childSnapshot.value["image"] as! String
     
     var ing = ""
     if (childSnapshot.value.valueForKey("ing") != nil){
     ing = childSnapshot.value["ing"] as! String
     }
     
     var price = ""
     if (childSnapshot.value.valueForKey("price") != nil){
     price = childSnapshot.value["price"] as! String
     }
     
     let foodId = child.key!
     
     let newFood = Food(id: foodId!, name: someValue, chefId: chef, url: someImageUrl, ing: ing, price: price)
     foods!.append(newFood)
     foodMap![foodId!] = newFood
     }
     
     handler(foods!)
     })
     }
     } */
    
    /*
     static func getFoodById(_ id: String)->Food?{
     if(foodMap != nil){
     if let theFood = foodMap![id]{
     return theFood
     }
     else{
     return nil
     }
     }else{
     return nil
     }
     }*/
    
}

//Extension to read a boolean value from a string
extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}
