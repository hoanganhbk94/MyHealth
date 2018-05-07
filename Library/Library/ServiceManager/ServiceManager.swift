//
//  ServiceManager.swift
//  Library
//
//  Created by Duong Le Bac on 11/13/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import Foundation

open class ServiceManager {
    public typealias DataCompletion = (_ successed: Bool, _ statusCode: HttpStatusCode, _ reponse: [String : Any]?) -> Void
    
    public var defaultHeaders: [String : String] = {
        return [:]
    }()
    
    public init() {
        
    }
    
    func handleResponseData(response: DataResponse<Any>, completionHandler: @escaping DataCompletion) {
        guard let statusCode = response.response?.statusCode, let code = HttpStatusCode(rawValue: statusCode), code == .ok else {
            guard let status = response.response?.statusCode, let httpStatusCode = HttpStatusCode(rawValue: status) else {
                Logw(msg: "error = \(response)")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ServiceConfig.sessionErrorNotificationName), object: Status(code: .unknown, message: Network.isConnected() ? response.error?.localizedDescription : Localizable.Message.ApiError.error_network))
                completionHandler(false, .unknown, nil)
                return
            }
            guard let json = response.value as? [String : Any], json.count > 0, let message = json["message"] as? String else {
                Logw(msg: "error = \(response) code = \(httpStatusCode)")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: ServiceConfig.sessionErrorNotificationName), object: Status(code: httpStatusCode, message: Network.isConnected() ?  response.error?.localizedDescription : Localizable.Message.ApiError.error_network))
                completionHandler(false, httpStatusCode, nil)
                return
            }
            Logw(msg: response.response?.statusCode ?? 0)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ServiceConfig.sessionErrorNotificationName), object: Status(code: httpStatusCode, message: message))
            completionHandler(false, httpStatusCode, nil)
            return
        }
        Logw(msg: response.value ?? [:])
        guard let json = response.value as? [String : Any], json.count > 0 else {
            completionHandler(false, code, nil)
            return
        }
        completionHandler(true, code, json)
    }
    
    open func getDataFromServer(urlStr: String, parameters: [String : Any]?, completionHandler: @escaping DataCompletion) {
        request(urlStr, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: defaultHeaders).responseJSON { (response) in
            Logw(msg: "get urlStr = \(response.request!)")
            Logw(msg: "get params = \(parameters ?? [:])")
            Logw(msg: "defaultHeaders = \(self.defaultHeaders)")
            self.handleResponseData(response: response, completionHandler: completionHandler)
        }
    }
    
    open func postDataFromServer(urlStr: String, parameters: [String : Any]?, completionHandler: @escaping DataCompletion)  {
        request(urlStr, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders).responseJSON { (response) in
            Logw(msg: "post urlStr = \(urlStr)")
            Logw(msg: "post params = \(parameters ?? [:])")
            Logw(msg: "defaultHeaders = \(self.defaultHeaders)")
            self.handleResponseData(response: response, completionHandler: completionHandler)
        }
    }
    
    open func patchDataFromServer(urlStr: String, parameters: [String : Any]?, completionHandler: @escaping DataCompletion) {
        request(urlStr, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders).responseJSON { (response) in
            Logw(msg: "patch urlStr = \(urlStr)")
            Logw(msg: "patch params = \(parameters ?? [:])")
            Logw(msg: "defaultHeaders = \(self.defaultHeaders)")
            self.handleResponseData(response: response, completionHandler: completionHandler)
        }
    }
    
    open func putDataFromServer(urlStr: String, parameters: [String : Any]?, completionHandler: @escaping DataCompletion) {
        request(urlStr, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders).responseJSON { (response) in
            Logw(msg: "put urlStr = \(urlStr)")
            Logw(msg: "put params = \(parameters ?? [:])")
            Logw(msg: "defaultHeaders = \(self.defaultHeaders)")
            self.handleResponseData(response: response, completionHandler: completionHandler)
        }
    }
    
    open func deleteDataFromServer(urlStr: String, parameters: [String : Any]?, completionHandler: @escaping DataCompletion) {
        request(urlStr, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: defaultHeaders).responseJSON { (response) in
            Logw(msg: "delete urlStr = \(urlStr)")
            Logw(msg: "delete params = \(parameters ?? [:])")
            Logw(msg: "defaultHeaders = \(self.defaultHeaders)")
            self.handleResponseData(response: response, completionHandler: completionHandler)
        }
    }
    
    open func uploadFileToServer(urlStr: String, parameters: [String : Any]?, imageData: Data, completionHandler: @escaping DataCompletion) {
        upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData, withName: "avatar", fileName: "avatar.jpeg", mimeType: "image/jpeg")
            if parameters != nil && parameters!.count > 0 {
                for (key, value) in parameters! {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
        }, to: urlStr, method: .post, headers: defaultHeaders) { (dataResult) in
            switch dataResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    Logw(msg: "upload urlStr = \(urlStr)")
                    Logw(msg: "upload params = \(parameters ?? [:])")
                    Logw(msg: "defaultHeaders = \(self.defaultHeaders)")
                    self.handleResponseData(response: response, completionHandler: completionHandler)
                }
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
                completionHandler(false, .upload_failed, nil)
                break
            }
        }
    }
}
