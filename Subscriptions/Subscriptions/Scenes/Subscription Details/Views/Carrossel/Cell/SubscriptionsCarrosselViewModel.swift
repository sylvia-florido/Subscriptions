//
//  SubscriptionsCarrosselViewModel.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

struct SubscriptionsCarrosselViewModel {
    let title: String
    let subtitle: String
    let descritionText: String
    let imageUrl: String
    
    init(with model: SubscriptionDetails) {
        title = model.name
        subtitle = model.authors.first?.name ?? ""
        descritionText = model.longDescription
        imageUrl = model.backgroundLarge
    }
}
