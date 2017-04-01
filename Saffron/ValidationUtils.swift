//
//  ValidationRules.swift
//  Saffron
//
//  Created by Erica Solum on 3/29/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import Foundation
import Validator

/*public enum ValidationErrors: String, Error {
    case nameInvalid = "Name is required"
    case shortDescInvalid = "Short description must be between 1 and 140 characters"
    case longDescInvalid = "Description is required"
    case priceInvalid = "Price is required"
    case servingInvalid = "Serving type must be less than 20 characters"
    case numServingsInvalid = "Total number of servings is required"
    
    public var message: String {
        return self.rawValue
    }
}*/


struct ValidationError: Error {
    
    public let message: String
    
    public init(message m: String) {
        message = m
    }
}

class ValidationUtils {
    static let stringRequiredRule = ValidationRuleLength(min: 1, error: ValidationError(message: "Required"))
    static let maxSmallLengthRule = ValidationRuleLength(max: 20, error: ValidationError(message: "Must be less than 20 characters"))
    static let maxMedLengthRule = ValidationRuleLength(max: 140, error: ValidationError(message: "Must be less than 140 characters"))
    static let maxLongLengthRule = ValidationRuleLength(max: 1000, error: ValidationError(message: "Must be less than 1000 characters"))
    static let doubleRequiredRule = ValidationRuleRequired<Double>(error: ValidationError(message: "Required"))
    static let intRequiredRule = ValidationRuleRequired<Int>(error: ValidationError(message: "Required"))
}

