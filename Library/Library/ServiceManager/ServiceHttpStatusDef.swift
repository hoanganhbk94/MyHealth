//
//  ServiceHttpStatusDef.swift
//  Library
//
//  Created by Duong Le Bac on 11/14/17.
//  Copyright © 2017 Eastgate Software. All rights reserved.
//

import Foundation

public enum HttpStatusCode: Int {
    case ok                         = 200
    case bad_request                = 400
    case valid_api_key              = 401
    case access_denied              = 403
    case not_found                  = 404
    case not_allowed                = 405
    case missing_required_params    = 422
    case too_many_attemps           = 429
    case internal_error             = 500
    case offline_maintainace        = 503
    case unknown
    case upload_failed
}

public struct ServiceConfig {
    public static let sessionErrorNotificationName = "sessionErrorNotificationName"
}

public struct Status {
    public var code: HttpStatusCode = .unknown
    public var message: String = "unknown"
    
    init(code: HttpStatusCode, message: String?) {
        self.code = code
        self.message = message!
    }
}

public struct Network {
    public static func isConnected() -> Bool {
        guard let reachabilityManager = NetworkReachabilityManager() else {
            return false
        }
        return reachabilityManager.isReachable
    }
}
