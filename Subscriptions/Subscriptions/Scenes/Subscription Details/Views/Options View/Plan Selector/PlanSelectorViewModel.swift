//
//  PlanSelectorViewModel.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

enum PlanOption: Int {
    case left
    case right
}

struct PlanSelectorViewModel {
    let option: PlanOption
    let accentText: String?
    let plan: String
    let price: String
    let period: String
    let equalMonthlyText: String
    let selected: Bool
}
