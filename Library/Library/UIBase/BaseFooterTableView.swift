//
//  BaseFooterTableView.swift
//  Library
//
//  Created by Duong Le Bac on 2/23/18.
//  Copyright © 2018 Eastgate Software. All rights reserved.
//

import UIKit

class BaseFooterTableView: BaseView {

    private var _isAnimating = false
    
    var isAnimating: Bool{
        get{
            return _isAnimating
        }
        set{
            _isAnimating = newValue
            if newValue{
                self.indicatorView!.startAnimating()
            }
        }
    }
    
    private var indicatorView: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        self.indicatorView!.startAnimating()
        self.indicatorView!.hidesWhenStopped = true
        self.addSubview(self.indicatorView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.indicatorView!.center = CGPoint(x: self.frame.size.width / 2.0, y: 35.0)
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
