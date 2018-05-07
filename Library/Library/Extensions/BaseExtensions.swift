//
//  BaseExtensions.swift
//  Library
//
//  Created by Duong Le Bac on 11/6/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import Foundation

extension Dictionary {
    public func getStringValueForKey(key: String) -> String {
        guard let dicts = self as? [String : Any], let value = dicts[key] as? String else {
            //Logw(msg: "dynamicType string")
            return ""
        }
        return value
    }
    
    public func getIntValueForKey(key: String) -> Int {
        guard let dicts = self as? [String : Any], let value = dicts[key] as? Int else {
            //Logw(msg: "dynamicType int")
            return 0
        }
        return value
    }
    
    public func getBoolValueForKey(key: String) -> Bool {
        guard let dicts = self as? [String : Any], let value = dicts[key] as? Bool else {
            //Logw(msg: "dynamicType bool")
            return false
        }
        return value
    }
    
    public func getCGFloatValueForKey(key: String) -> CGFloat {
        guard let dicts = self as? [String : Any], let value = dicts[key] as? CGFloat else {
            //Logw(msg: "dynamicType float")
            return 0.0
        }
        return value
    }
    
    public func getDoubleValueForKey(key: String) -> Double {
        guard let dicts = self as? [String : Any], let value = dicts[key] as? Double else {
            //Logw(msg: "dynamicType double")
            return 0.0
        }
        return value
    }
    
    public func getArrayValueForKey(key: String) -> Array<Any> {
        guard let dicts = self as? [String : Any], let value = dicts[key] as? Array<Any> else {
            //Logw(msg: "dynamicType array")
            return []
        }
        return value
    }
    
    public func getArrayStringValueForKey(key: String) -> Array<String> {
        guard let dicts = self as? [String : Any], let value = dicts[key] as? Array<String> else {
            //Logw(msg: "dynamicType array")
            return []
        }
        return value
    }
    
    public func getDictionaryValueForKey(key: String) -> Dictionary {
        guard let dicts = self as? [String : Any], let value = dicts[key] as? Dictionary else {
            //Logw(msg: "dynamicType dictionary")
            return [:]
        }
        return value
    }
    
    public func getDictionaryStringValueForKey(key: String) -> [String : String] {
        guard let dicts = self as? [String : Any], let value = dicts[key] as? [String : String] else {
            //Logw(msg: "dynamicType dictionary")
            return [:]
        }
        return value
    }
}

extension NSDictionary {
    public func getStringValueForKey(key: String) -> String {
        if let val = self.object(forKey: key) {
            if (val as AnyObject).isKind(of: NSString.self) {
                return (val as? String)!
            } else if (val as AnyObject).isKind(of: NSNumber.self) {
                return String(describing: val)
            }
        }
        return ""
    }
    
    public func getIntValueForKey(key: String) -> Int {
        let val = self.object(forKey: key)
        if val != nil && (val as AnyObject).isKind(of: NSNumber.self) {
            return (val as? Int)!
        }
        if val != nil && (val as AnyObject).isKind(of: NSString.self) {
            return Int((val as? NSString)!.intValue)
        }
        return 0
    }
    
    public func getBoolValueForKey(key: String) -> Bool {
        let val = self.object(forKey: key)
        if val is Bool {
            return (val as? Bool)!
        }
        if val != nil && (val as AnyObject).isKind(of: NSString.self) {
            return val! as? String == "true"
        }
        return false
    }
    
    public func getCGFloatValueForKey(key: String) -> CGFloat {
        let val = self.object(forKey: key)
        if val != nil && (val as AnyObject).isKind(of: NSNumber.self) {
            return (val as? CGFloat)!
        }
        if val != nil && (val as AnyObject).isKind(of: NSString.self) {
            return CGFloat(((val as AnyObject).floatValue)!)
        }
        return 0.0
    }
    
    public func getArrayValueForKey(key: String) -> NSArray {
        let val = self.object(forKey: key)
        if val != nil && (val as AnyObject).isKind(of: NSArray.self) {
            return (val as? NSArray)!
        }
        return []
    }
    
    public func getDictionaryValueForKey(key: String) -> NSDictionary {
        let val = self.object(forKey: key)
        if val != nil && (val as AnyObject).isKind(of: NSDictionary.self) {
            return (val as? NSDictionary)!
        }
        return [:]
    }
}

public extension UIColor {
    
    public convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    public convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(hexa: Int) {
        self.init(
            red: (hexa >> 16) & 0xFF,
            green: (hexa >> 8) & 0xFF,
            blue: hexa & 0xFF
        )
    }
}

extension UIImage {
    public func resizeImage(newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
