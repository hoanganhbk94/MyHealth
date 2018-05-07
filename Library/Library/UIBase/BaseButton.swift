//
//  BaseButton.swift
//  Carbooking
//
//  Created by Duong Le Bac on 10/20/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import UIKit

@IBDesignable
open class BaseButton: UIButton {
    private var _cornerRadius: CGFloat = 0.0
    private var _borderWidth: CGFloat = 0.0
    
    private var _prBorderColor: UIColor = UIColor.white
    
    @IBInspectable var cornerRadius: CGFloat {
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
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    public func setTitleAndImageEdgeInsert(_ spacing: CGFloat) {
        // Lower the text and push it left so it appears centered below the image
        let imageSize: CGSize = self.imageView!.image!.size
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        
        // Raise the image and push it right so it appears centered above the text
        let titleSize = (self.titleLabel!.text! as NSString).size(withAttributes: [NSAttributedStringKey.font: self.titleLabel!.font])
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
