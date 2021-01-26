//
//  SubscriptionsRepository.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import Foundation

enum SubscriptionsServiceErrors: String {
    case parseToModel = "Couldn't parse response to model."
    case emptyData = "No data available"
    case otherErrorExample = "Other errors may happen, this coul be a separate file if the error message grow too much"
}

class SubscriptionsRepository {
    
    // MARK: Shared
    class func sharedInstance() -> SubscriptionsRepository {
        struct Singleton {
            static var sharedInstance = SubscriptionsRepository()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: Helpers
    func createError(_ error: SubscriptionsServiceErrors) -> NSError {
        return NSError(domain: "convertData", code: 1, userInfo: [NSLocalizedDescriptionKey: [NSLocalizedDescriptionKey : error.rawValue]])
    }
    
    // MARK: API calls
    func getSubscriptionsList(_ completionHandler: @escaping (_ response: [SubscriptionDetails]?, _ error: NSError?) -> Void) {
        
        let request = SubscriptionsRequest()
        BaseRequester().taskForGETMethod(request: request, responseType: SubscriptionResponse.self) { (response, error) in
            if let response = response {
                let details = response.groups
                completionHandler(details, nil)
            } else {
                completionHandler(nil, error)
            }
        }
        
    }
    
}
