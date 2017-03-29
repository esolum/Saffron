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
    var newMeal: Meal!
    var assets: [DKAsset]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        print(date)
        newMeal.setDate(date: date)
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
