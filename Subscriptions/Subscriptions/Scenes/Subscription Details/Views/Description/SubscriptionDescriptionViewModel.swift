//
//  SubscriptionDescriptionViewModel.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

struct SubscriptionDescriptionViewModel {
    let smallProfileUrlString: String?
    let about: String
    let authorProfileImage: UIImage?
    let authorName: String
    var featues: [SummaryViewModel]?
    
    static func viewModel(with subscription: SubscriptionDetails) -> SubscriptionDescriptionViewModel {
        let summaryViewModel = subscription.features.map({ (feature) -> SummaryViewModel in
            return SummaryViewModel(title: feature.title, subtitle: feature.featureDescription)
        })
        return SubscriptionDescriptionViewModel(smallProfileUrlString: subscription.authors.first?.photoSmallUrl, about: subscription.longDescription, authorProfileImage: nil, authorName: subscription.authors.first?.name ?? "", featues: summaryViewModel)
    }
}
