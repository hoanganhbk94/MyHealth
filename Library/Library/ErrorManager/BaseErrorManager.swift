//
//  BaseErrorManager.swift
//  Library
//
//  Created by Duong Le Bac on 11/8/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import Foundation

extension UIViewController {
    
    open func showAlert(title titleStr: String, message msg: String) {
        let alertViewController = UIAlertController(title: titleStr, message: msg, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: Localizable.Title.Common.okay, style: .cancel) { (_) in
            // Cancel
        }
        alertViewController.addAction(okayAction)
        DispatchQueue.main.async {
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    open func showAlert(title titleStr: String, message msg: String, completion:@escaping (_ success: Bool)->Void) {
        let alertViewController = UIAlertController(title: titleStr, message: msg, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: Localizable.Title.Common.okay, style: .cancel) { (_) in
            // Okay
            completion(true)
        }
        alertViewController.addAction(okayAction)
        DispatchQueue.main.async {
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    open func showAlert(title titleStr: String, message msg: String, cancelActionTitle title: String) {
        let alertViewController = UIAlertController(title: titleStr, message: Localizable.Message.Common.confirm, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: title, style: .cancel) { (_) in
            // Cancel
        }
        alertViewController.addAction(cancelAction)
        DispatchQueue.main.async {
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
    
    open func showAlert(title titleStr: String, message msg: String, cancelActionTitle cancelTitle: String, defaultActionTitle defaultTitle: String, completion:@escaping (_ success: Bool,_ style: UIAlertActionStyle)->Void) {
        let alertViewController = UIAlertController(title: titleStr, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (_) in
            // Cancel
            completion(true, .cancel)
        }
        alertViewController.addAction(cancelAction)
        let defaultAction = UIAlertAction(title: defaultTitle, style: .default) { (_) in
            // Default
            completion(true, .default)
        }
        alertViewController.addAction(defaultAction)
        DispatchQueue.main.async {
            self.present(alertViewController, animated: true, completion: nil)
        }
    }
}
