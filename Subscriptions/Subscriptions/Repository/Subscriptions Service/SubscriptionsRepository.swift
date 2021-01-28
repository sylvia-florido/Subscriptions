//
//  SubscriptionsRepository.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import Foundation
import UIKit

public typealias GenericError = ((_ errorMessage: String) -> Void)

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
    func getSubscriptionsList(success: @escaping ((_ response: [SubscriptionDetails]) -> Void),
                              failure: @escaping GenericError) {
        
        let request = SubscriptionsRequest()
        BaseRequester().taskForGETMethod(request: request, responseType: SubscriptionResponse.self) { (response, error) in
            if let response = response {
                let details = response.groups
                success(details)
            } else {
                failure("Parse error")
            }
        }
    }
    
    
    // MARK: - Images
    func getImage(withURL url:URL, completion: @escaping (_ image: UIImage?)->()) {
        BaseRequester.getImage(withURL: url, completion: completion)
    }
    
    func getImage(with urlString: String?, completion: @escaping (_ image:UIImage?)->()) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        getImage(withURL: url, completion: completion)
    }
    
    func cacheImage(withURL url:URL, completion: @escaping (_ success: Bool)->()) {
        BaseRequester.cacheImage(withURL: url, completion: completion)
    }
    
}
