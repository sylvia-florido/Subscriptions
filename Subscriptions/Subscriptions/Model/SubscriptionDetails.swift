//
//  SubscriptionDetails.swift
//  Subscriptions
//
//  Created by Me on 26/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import Foundation

class SubscriptionDetails: Decodable {
    let name: String
    let shortDescription: String
    let longDescription: String
    let backgroundLarge: String
    let backgroundSmall: String
    let identifier: String
    let authors: [Authors]
    let features: [Features]

    private enum CodingKeys: String, CodingKey {
        case name, shortDescription, backgroundLarge, backgroundSmall, identifier, authors, features
        case longDescription = "description"
    }
    
    private enum IdentifierCodingKeys: String, CodingKey {
        case slug
    }
    
    required public init(from decoder: Decoder) throws {
        let topContainer = try decoder.container(keyedBy: CodingKeys.self)
        name = try topContainer.decode(String.self, forKey: .name)
        shortDescription = try topContainer.decode(String.self, forKey: .shortDescription)
        longDescription = try topContainer.decode(String.self, forKey: .longDescription)
        backgroundLarge = try topContainer.decode(String.self, forKey: .backgroundLarge)
        backgroundSmall = try topContainer.decode(String.self, forKey: .backgroundSmall)
        authors = try topContainer.decode([Authors].self, forKey: .authors)
        features = try topContainer.decode([Features].self, forKey: .features)
        
        let idContainer = try topContainer.nestedContainer(keyedBy: IdentifierCodingKeys.self, forKey: .identifier)
        identifier = try idContainer.decode(String.self, forKey: .slug)
    }
}
