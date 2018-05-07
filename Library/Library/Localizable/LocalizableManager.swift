//
//  LocalizableManager.swift
//  Library
//
//  Created by Duong Le Bac on 11/9/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import Foundation

public func Localized(str: String) -> String {
    return NSLocalizedString(str, comment: str)
}

open class Localizable {
    public struct Title {
        public struct Common {
            public static let cancel: String    = Localized(str: "title_alert_cancel")
            public static let okay: String      = Localized(str: "title_alert_ok")
        }
    }
    public struct Message {
        public struct Common {
            public static let confirm: String   = Localized(str: "msg_alert_test")
        }
        public struct ApiError {
            public static let unknown: String           = Localized(str: "msg_error_unknown")
            public static let error_network: String     = Localized(str: "msg_error_network")
        }
    }
}
