//
//  BaseViewController.swift
//  Library
//
//  Created by Duong Le Bac on 10/20/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController {
    private var prLeftImage: UIImage?
    private var prRightImage: UIImage?
    
    var leftBarButtonItem: UIBarButtonItem?
    var rightBarButtonItem: UIBarButtonItem?
    
    open var leftImage: UIImage {
        get {
            return prLeftImage!
        }
        set {
            prLeftImage = newValue
            self.leftBarButtonItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(BaseViewController.leftBarButtonItemClicked(_:)))
            self.navigationItem.leftBarButtonItem = self.leftBarButtonItem
        }
    }
    
    open var rightImage: UIImage {
        get {
            return prRightImage!
        }
        set {
            prRightImage = newValue
            self.rightBarButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(BaseViewController.rightBarButtonItemClicked(_:)))
            self.navigationItem.rightBarButtonItem = self.rightBarButtonItem
        }
    }

    
    public init(nibName nibNameOrNil: String?) {
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation item action
    
    @objc open func leftBarButtonItemClicked(_ leftBarButtonItem: UIBarButtonItem) {
        //Do something
    }
    
    @objc open func rightBarButtonItemClicked(_ rightBarButtonItem: UIBarButtonItem) {
        //Do something
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
