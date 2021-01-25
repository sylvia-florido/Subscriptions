//
//  CardBorderStyle.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

public class CardBorderStyle: NSObject {
    
    let width: CGFloat
    let color: UIColor?
    
    public init(width: CGFloat, color: UIColor?) {
        self.width = width
        self.color = color
        super.init()
    }
    
    public static var none    = CardBorderStyle(width: 0.0, color: nil)
    public static var thinGreen    = CardBorderStyle(width: 1.0, color: Colors.accentGreen)
    public static var mediumGreen  = CardBorderStyle(width: 2.0, color: Colors.accentGreen)
    public static var thinGray    = CardBorderStyle(width: 1.0, color: Colors.accentGreen)
    public static var mediumGray  = CardBorderStyle(width: 2.0, color: Colors.accentGreen)
}
