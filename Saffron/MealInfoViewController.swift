//
//  MealInfoViewController.swift
//  Saffron
//
//  View controller for the second phase of adding a new meal.
//
//  Created by Erica Solum on 3/16/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import TextFieldEffects
import DKImagePickerController

class MealInfoViewController: UIViewController {

    //MARK: Properties
    
    @IBOutlet weak var nameField: HoshiTextField!
    @IBOutlet weak var shortDescField: HoshiTextField!
    @IBOutlet weak var longDescField: HoshiTextField!
    @IBOutlet weak var priceField: HoshiTextField!
    @IBOutlet weak var servingField: HoshiTextField!
    @IBOutlet weak var numberServicesField: HoshiTextField!
    
    var newMeal: Meal!
    var assets: [DKAsset]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "detailsToTime" {
            let vc = segue.destination as! MealTimeViewController
                
                vc.newMeal = newMeal
                vc.assets = assets
        }
    }

}
