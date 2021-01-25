//
//  RoundedButton.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable public var fontSize: CGFloat = 18.0 {
        didSet {
            titleLabel?.font =  UIFont(name: "TTCommons-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize - 4, weight: .semibold)
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 4 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // MARK: - Icon
    @IBInspectable public var iconTintColor: UIColor = .white {
        didSet {
            tintColor = iconTintColor
        }
    }

    @IBInspectable public var iconName: String? {
        didSet {
            guard let iconName = iconName, let image = UIImage(named: iconName, in: Bundle(for: RoundedButton.self), compatibleWith: nil) else { return }
            self.imageView?.contentMode = .scaleAspectFit
            
            setImage(image, for: .normal)
        }
    }
    
    public var externalImage: UIImage? {
        didSet {
            setImage(externalImage, for: .normal)
        }
    }
    
    // MARK: - Init / Setup
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = UIEdgeInsets(top: -2, left: -20, bottom: 2, right: 0)
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        titleLabel?.font = UIFont(name: "TTCommons-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize - 4, weight: .semibold)
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .highlighted)
        setTitleColor(.white, for: .disabled)
        backgroundColor = Colors.accentMainColor
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
}
