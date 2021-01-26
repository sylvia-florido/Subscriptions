//
//  Features.swift
//  Subscriptions
//
//  Created by Me on 26/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import Foundation

class Features: Decodable {
    let title: String
    let featureDescription: String
    
    private enum CodingKeys: String, CodingKey {
        case title
        case featureDescription = "description"
    }
}
