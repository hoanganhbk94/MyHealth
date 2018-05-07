//
//  BaseSegmentedControl.swift
//  Library
//
//  Created by Duong Le Bac on 2/7/18.
//  Copyright © 2018 Eastgate Software. All rights reserved.
//

import UIKit

@IBDesignable
open class BaseSegmentedControl: UISegmentedControl {
    private var _cornerRadius: CGFloat = 0.0
    private var _borderWidth: CGFloat = 0.0
    private var _prBorderColor: UIColor = UIColor.white
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return _cornerRadius
        }
        set {
            _cornerRadius = newValue
            self.layer.cornerRadius = _cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            self.layer.borderWidth = _borderWidth
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return _prBorderColor
        }
        set {
            _prBorderColor = newValue
            self.layer.borderColor = _prBorderColor.cgColor
            self.layer.masksToBounds = true
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
