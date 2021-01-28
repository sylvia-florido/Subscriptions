//
//  SubscriptionPlan.swift
//  Subscriptions
//
//  Created by Me on 27/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import Foundation

class SubscriptionPlan: Decodable {
    let identifier: String
    let accentText: String?
    let planValue: String
    let byMonthValue: String?
    let period: String
    
    init(identifier: String, accentText: String?, planValue: String, byMonthValue: String?, period: String) {
        self.identifier = identifier
        self.accentText = accentText
        self.planValue = planValue
        self.byMonthValue = byMonthValue
        self.period = period
    }
}
