//
//  BaseTextField.swift
//  Carbooking
//
//  Created by Duong Le Bac on 10/20/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import UIKit

open class BaseTextField: UITextField {

    open func setSecure(show isShow: Bool) {
        self.isSecureTextEntry = !isShow
    }
    
    open func isTextEmpty() -> Bool {
        return self.text == nil || self.text!.isEmpty
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
