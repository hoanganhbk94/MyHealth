//
//  BaseUtility.swift
//  Library
//
//  Created by Duong Le Bac on 11/6/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import Foundation

open class BaseUtility {    
    // MARK: - Localizable
    
    open static func localized(str: String) -> String {
        return NSLocalizedString(str, comment: str)
    }
    
    // MAKR: - Device info
    
    open static func getBundleId() -> String {
        return Bundle.main.bundleIdentifier!
    }
    
    open static func getDisplayName() -> String {
        return (Bundle.main.infoDictionary![kCFBundleNameKey as String] as? String)!
    }
    
    open static func getPlatform() -> String {
        return UIDevice.current.name
    }
    
    open static func getOS() -> String {
        return UIDevice.current.systemVersion
    }
    
    open static func getAppVersion() -> String {
        let infoDict = Bundle.main.infoDictionary
        return (infoDict!["CFBundleShortVersionString"] as? String)!
    }
    
    open static func getLanguageCode() -> String {
        if let languageCode = Locale.current.languageCode {
            return languageCode
        }
        return "en"
    }
    
    // MARK: - Constraint String
    
    open static func heightForString (string: String, constrainedToWidth width: CGFloat, withFont font: UIFont) -> CGFloat {
        return ceil(NSString(string: string).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                                                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                          attributes: [NSAttributedStringKey.font: font],
                                                          context: nil).size.height)
    }
    
    open static func widthForString (string: String, constrainedToHeight height: CGFloat, withFont font: UIFont) -> CGFloat {
        return ceil(NSString(string: string).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height),
                                                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                          attributes: [NSAttributedStringKey.font: font],
                                                          context: nil).size.width)
    }
    
    // MARK: - FileManager
    
    open static func applicationDocumentsDirectory() -> String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    }
    
    open static func directoryExistsAtPath(path: String) -> Bool {
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            return isDir.boolValue
        }
        return false
    }
}
