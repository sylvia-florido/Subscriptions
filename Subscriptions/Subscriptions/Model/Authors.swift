//
//  Authors.swift
//  Subscriptions
//
//  Created by Me on 26/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import Foundation

class Authors: Decodable {
    let name: String
    let photoSmallUrl: String
    let photoLargeUrl: String
    let role: String
    
    private enum CodingKeys: String, CodingKey {
        case name, photoSmallUrl, photoLargeUrl
        case role = "description"
    }
}
