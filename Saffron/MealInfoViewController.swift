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
import SkyFloatingLabelTextField
import DKImagePickerController
import Validator

class MealInfoViewController: UIViewController, UITextFieldDelegate {

    //MARK: Properties
    
    @IBOutlet weak var nameField: SkyFloatingLabelTextField!
    @IBOutlet weak var shortDescField: SkyFloatingLabelTextField!
    @IBOutlet weak var longDescField: SkyFloatingLabelTextField!
    @IBOutlet weak var priceField: SkyFloatingLabelTextField!
    @IBOutlet weak var servingField: SkyFloatingLabelTextField!
    @IBOutlet weak var numberServingsField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var newMeal: Meal!
    var assets: [DKAsset]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameField.delegate = self
        shortDescField.delegate = self
        longDescField.delegate = self
        priceField.delegate = self
        servingField.delegate = self
        numberServingsField.delegate = self
        
        nextButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Text Field Delegate Functions
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameField {
            
            var ruleSet = ValidationRuleSet<String>()
            ruleSet.add(rule: ValidationUtils.stringRequiredRule)
            ruleSet.add(rule: ValidationUtils.maxMedLengthRule)
            
            let result = Validator.validate(input: textField.text!, rules: ruleSet)
            
            switch result {
                case .valid:
                        newMeal.setName(name: textField.text!)
                case .invalid(let failures):
                    let errors = failures as! [ValidationError]
                    print(errors.first!.message)
            }
        }
        else if textField == shortDescField {
            
            var ruleSet = ValidationRuleSet<String>()
            ruleSet.add(rule: ValidationUtils.stringRequiredRule)
            ruleSet.add(rule: ValidationUtils.maxMedLengthRule)
            
            let result = Validator.validate(input: textField.text!, rules: ruleSet)
            
            switch result {
            case .valid:
                newMeal.setShortDescription(shortDesc: textField.text!)
            case .invalid(let failures):
                let errors = failures as! [ValidationError]
                print(errors.first!.message)
            }
        }
        else if textField == longDescField {
            var ruleSet = ValidationRuleSet<String>()
            ruleSet.add(rule: ValidationUtils.stringRequiredRule)
            ruleSet.add(rule: ValidationUtils.maxLongLengthRule)
            
            let result = Validator.validate(input: textField.text!, rules: ruleSet)
            
            switch result {
                case .valid:
                    newMeal.setDescription(desc: textField.text!)
                case .invalid(let failures):
                    let errors = failures as! [ValidationError]
                    print(errors.first!.message)
            }
        }
        else if textField == servingField {
            var ruleSet = ValidationRuleSet<String>()
            ruleSet.add(rule: ValidationUtils.stringRequiredRule)
            ruleSet.add(rule: ValidationUtils.maxSmallLengthRule)
            
            let result = Validator.validate(input: textField.text!, rules: ruleSet)
            
            
            switch result {
            case .valid:
                newMeal.setServingType(type: textField.text!)
            case .invalid(let failures):
                let errors = failures as! [ValidationError]
                print(errors.first!.message)
                
            }
        }
        else if textField == priceField {
            var ruleSet = ValidationRuleSet<Double>()
            ruleSet.add(rule: ValidationUtils.doubleRequiredRule)
            
            let result = Validator.validate(input: Double(textField.text!), rules: ruleSet)
        
            switch result {
                case .valid:
                    newMeal.setPrice(price: Double(textField.text!)!)
                case .invalid(let failures):
                    let errors = failures as! [ValidationError]
                    print(errors.first!.message)
            }
        }
        else if textField == numberServingsField {
            var ruleSet = ValidationRuleSet<Int>()
            ruleSet.add(rule: ValidationUtils.intRequiredRule)
            
            let result = Validator.validate(input: Int(textField.text!), rules: ruleSet)
            
            switch result {
                case .valid:
                    newMeal.setTotalServings(servings: Int(textField.text!)!)
                case .invalid(let failures):
                    let errors = failures as! [ValidationError]
                    print(errors.first!.message)
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if nameField.hasText && shortDescField.hasText && longDescField.hasText && priceField.hasText && servingField.hasText && numberServingsField.hasText {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
        }
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
