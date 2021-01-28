//
//  SubscriptionOptionsViewModel.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

struct SubscriptionOptionsViewModel {
    let subscriptionName: String
    let largeBackgroundUrlString: String?
    let strategistImage: UIImage?
    let strategistAdvice: String?
    let disclaimer: String?
    let leftPlanViewModel: PlanSelectorViewModel
    let rightPlanViewModel: PlanSelectorViewModel
}
