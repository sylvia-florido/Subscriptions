//
//  BorderView.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

@IBDesignable
open class BorderView: UIView {
    
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 4.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var maskedCornersBitMask: UInt = 0 {
        didSet {
            layer.maskedCorners = CACornerMask.init(rawValue: maskedCornersBitMask)
        }
    }
    
    // MARK: - Border
    
    //MARK: - Init and life cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public init(borderStyle: CardBorderStyle) {
        super.init(frame: .zero)
        apply(borderStyle: borderStyle)
    }
    
    func setup() {
        layer.cornerRadius = cornerRadius
        apply(borderStyle: CardBorderStyle(width: borderWidth, color: borderColor))
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderWidth = 2
        layer.borderColor = Colors.accentGreen?.cgColor
    }
    
    func apply(borderStyle: CardBorderStyle) {
        layer.borderWidth = borderStyle.width
        layer.borderColor = borderStyle.color?.cgColor
    }

}

