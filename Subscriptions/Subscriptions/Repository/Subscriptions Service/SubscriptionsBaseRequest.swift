//
//  SubscriptionsBaseRequest.swift
//  Subscriptions
//
//  Created by Me on 26/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import Foundation


class SubscriptionsBaseRequest: BaseRequest {
    
    var rawUrl: String {
        get {
            return "https://empiricus-app.empiricus.com.br\(endpoint)"
        }
    }
    
    var endpoint: String {
        get {
            return ""
        }
    }
    
    var method: HTTPMethod {
        get {
            return .get
        }
    }
    
    var body: [String : Any]?
    
    var headers: [String : String]? = nil
    
}
