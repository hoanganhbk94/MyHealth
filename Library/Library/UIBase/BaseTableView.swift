//
//  BaseTableView.swift
//  Carbooking
//
//  Created by Duong Le Bac on 10/20/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import UIKit

open class BaseTableView: UITableView {
    private var _hasRefresh: Bool = false
    private var _hasLoadMore: Bool = false
    private var footerView: BaseFooterTableView = BaseFooterTableView(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 70.0)))
    
    @IBInspectable public var hasRefresh: Bool {
        get {
            return _hasRefresh
        }
        set {
            if newValue {
                self.refreshControl = UIRefreshControl()
            }
        }
    }
    
    @IBInspectable public var hasLoadMore: Bool {
        get{
            return _hasLoadMore
        }
        set{
            _hasLoadMore = newValue
            if (hasLoadMore) {
                self.footerView.isAnimating = true
                self.tableFooterView = self.footerView
            } else {
                if ((self.tableFooterView) != nil) {
                    UIView.animate(withDuration: 0.4, animations: { () -> Void in
                        self.tableFooterView = nil
                    })
                }
            }
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    open func updateTableViewContentInset() {
        let viewHeight: CGFloat = self.frame.size.height
        let tableViewContentHeight: CGFloat = self.contentSize.height
        if viewHeight > tableViewContentHeight {
            let marginHeight: CGFloat = (viewHeight - tableViewContentHeight) / 2.0
            self.contentInset = UIEdgeInsets(top: marginHeight, left: 0, bottom:  -marginHeight, right: 0)
        } else {
            self.contentInset = .zero
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
