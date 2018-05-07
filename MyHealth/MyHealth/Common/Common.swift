//
//  Common.swift
//  MyHealth
//
//  Created by Mai Hoang Anh on 5/4/18.
//  Copyright © 2018 Mai Hoang Anh. All rights reserved.
//

import UIKit
import SDWebImage

func openHealthApp() {
    if let healthAppUrl = URL(string: "x-apple-health://") {
        UIApplication.shared.open(healthAppUrl)
    }
}
