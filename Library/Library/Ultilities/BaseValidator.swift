//
//  BaseValidator.swift
//  Library
//
//  Created by Duong Le Bac on 11/8/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import Foundation

open class BaseValidator {
    open static func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
}
