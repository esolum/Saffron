//
//  MealTimeViewController.swift
//  Saffron
//
//  Created by Erica Solum on 3/27/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit
import WWCalendarTimeSelector
import DKImagePickerController

class MealTimeViewController: UIViewController, WWCalendarTimeSelectorProtocol {
    
    //MARK: Properties
    @IBOutlet weak var chooseDateButton: UIButton!
    @IBOutlet weak var chosenTimeLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var newMeal: Meal!
    var assets: [DKAsset]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        doneButton.isEnabled = false
    }

    //Button action methods
    @IBAction func presentCalendar(_ sender: UIButton) {
        
        let gradient = [UIUtils.coral, UIUtils.orange, UIUtils.yellow].gradient()
        
        
        let selector = WWCalendarTimeSelector.instantiate()
        selector.delegate = self
        selector.modalPresentationStyle = .overFullScreen
        selector.optionSelectionType = .single
        selector.optionStyleBlurEffect = .dark
        selector.optionCalendarFontMonth = UIUtils.monthFont
        selector.optionCalendarFontDays = UIUtils.dayFont
        selector.optionTopPanelBackgroundColor = UIUtils.coral
        selector.optionSelectorPanelBackgroundColor = UIUtils.coral
        selector.optionCalendarBackgroundColorTodayHighlight = UIUtils.coral
        selector.optionCalendarBackgroundColorPastDatesHighlight = UIUtils.coral
        selector.optionCalendarBackgroundColorFutureDatesHighlight = UIUtils.coral
        selector.optionClockBackgroundColorAMPMHighlight = UIUtils.coral
        selector.optionClockBackgroundColorHourHighlight = UIUtils.coral
        selector.optionClockBackgroundColorHourHighlightNeedle = UIUtils.coral
        selector.optionClockBackgroundColorMinuteHighlight = UIUtils.coral
        selector.optionClockBackgroundColorMinuteHighlightNeedle = UIUtils.coral
        
        
        present(selector, animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        FirebaseUtil.submitNewMeal(meal: newMeal, assets: assets)
    }
    
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        doneButton.isEnabled = true
        newMeal.setDate(date: date)
        chosenTimeLabel.text = MealUtils.stringFromDate(date: date, format: "MMM d, h:mm a")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
