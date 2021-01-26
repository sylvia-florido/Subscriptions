//
//  SubscriptionResponse.swift
//  Subscriptions
//
//  Created by Me on 26/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import Foundation

class SubscriptionResponse: Decodable {
    var groups: [SubscriptionDetails]
}
