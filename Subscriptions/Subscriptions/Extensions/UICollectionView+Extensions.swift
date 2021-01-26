//
//  UICollectionView+Extensions.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    public func register<C>(type: C.Type) where C : UICollectionViewCell {
        let className = String(describing: type)
        let nib = UINib(nibName: className, bundle: Bundle(for: C.self))
        register(nib, forCellWithReuseIdentifier: className)
    }
    

    public func dequeueReusableCell<C>(type: C.Type, for indexPath: IndexPath) -> C where C: UICollectionViewCell {
        let className = String(describing: type)
        guard let cell = dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as? C else {
            fatalError("Cell \(className) not registered")
        }
        return cell
    }
}
