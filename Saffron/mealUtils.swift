//
//  mealUtils.swift
//  Saffron
//
//  Created by Erica Solum on 3/28/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import Foundation

class MealUtils {
    
    class func convertToServingType(serving: String) -> ServingType{
        switch serving {
        case "cup":
            return .cup
        case "slice":
            return .slice
        case "scoop":
            return .scoop
        case "plate":
            return .plate
        default:
            return .other
        }
    }
    
    class func getDefaultDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        return dateFormatter
    }
    
    // Returns a Date from a given string
    class func dateFromString(dateStr: String) -> Date {
        let dateFormatter = getDefaultDateFormatter()
        
        //if date formatter returns nil return the current date/time
        if let date = dateFormatter.date(from: dateStr) {
            return date
        }
        else {
            return Date()
        }
    }
    
    // Return appropriate string representation of Date object
    class func stringFromDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}
