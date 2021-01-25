//
//  UITableView+Extensions.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        let className = String(describing: type)
        let nib = UINib(nibName: className, bundle: Bundle(for: T.self))
        register(nib, forCellReuseIdentifier: className)
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        let className = String(describing: type)
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T else {
            fatalError("Error: cell with id: \(className) for indexPath: \(indexPath) is not: \(T.self)")
        }
        return cell
    }
}
