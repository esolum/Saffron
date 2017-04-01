//
//  FollowingTableViewController.swift
//  Saffron
//
//  Created by Erica Solum on 2/16/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import ImageLoader
import NVActivityIndicatorView
import AMScrollingNavbar


class FollowingTableViewController: UITableViewController {

    //MARK: Properties
    var meals = [Meal]()
    var chosenMeal: Meal?
    var images = [String]()
    
    let kCloseCellHeight: CGFloat = 100
    let kOpenCellHeight: CGFloat = 214
    var cellHeights = [CGFloat]()
    let kRowsCount = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //FirebaseUtil.loadFoods(handleFood)
        FirebaseUtil.getMeals(handleMeals)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 50.0)
        }
        
        //Set up cells for automatic height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 269
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //loadSampleData()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Helper functions
    func loadSampleData() {
        /*let meal1 = Meal(id: "01", name: "Meal A La Nothing", chefId: "0000", url: "google.com", ingList: ["lions", "tigers", "bears"], price: 20.00)
        let meal2 = Meal(id: "02", name: "Some Loafy Thing", chefId: "0000", url: "google.com", ingList: ["apples", "oranges", "bananas"], price: 10.00)
        let meal3 = Meal(id: "01", name: "Fetticcu-wienie", chefId: "0000", url: "google.com", ingList: ["blah", "blah", "blah"], price: 5.00)
        
        let imgURL1 = "https://www.takethemameal.com/files_images/store/items/meatloaf-and-mac-and-jack.jpg"
        let imgURL2 = "https://s-media-cache-ak0.pinimg.com/originals/d6/5f/95/d65f95b1d68d8d1e939c7e132651901d.jpg"
        let imgURL3 = "http://assets.epicurious.com/photos/55f72d733c346243461d496e/master/pass/09112015_15minute_pastasauce_tomato.jpg"
        
        images.append(imgURL1)
        images.append(imgURL2)
        images.append(imgURL3)
        
        meals.append(meal1)
        meals.append(meal2)
        meals.append(meal3)*/
    }
    
    //Completion function to insert meals into table
    func handleMeals(_ meals: [Meal]){
        self.meals = meals
        print("Completion yo")
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return kRowsCount
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! FollowingTableViewCell

        // Configure the cell...
        cell.name.text = meals[indexPath.row].getName()
        cell.img.load.request(with: meals[indexPath.row].getImageURL())
        cell.shortDesc.text = meals[indexPath.row].getShortDescription()
        cell.price.text = meals[indexPath.row].getPriceString()
        //cell.image.load(foods[indexPath.row].imageUrl)
        //cell.image = foods[indexPath.row].
        return cell
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail"{
            let vc = segue.destination as? MealDetailViewController
            let index = self.tableView.indexPathForSelectedRow
                let selected = meals[(index?.row)!]
                vc?.meal = selected
            
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
