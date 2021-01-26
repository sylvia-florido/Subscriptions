//
//  SubscriptionsCarrosselView.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

class SubscriptionsCarrosselView: UIView, NibInstantiable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [SubscriptionsCarrosselViewModel] = [ SubscriptionsCarrosselViewModel(image: UIImage(), title: "title", subtitle: "subtitle"),
                                                     SubscriptionsCarrosselViewModel(image: UIImage(), title: "title1", subtitle: "subtitle1"),
                                                     SubscriptionsCarrosselViewModel(image: UIImage(), title: "title3", subtitle: "subtitle3")
    ]
    
    //MARK: - Lifecycle & Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.register(type: SubscriptionsCarrosselCollectionViewCell.self)
    }
}

extension SubscriptionsCarrosselView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: SubscriptionsCarrosselCollectionViewCell.self, for: indexPath)
//        cell.titleLabel.text = "ABC"
//        cell.subtitleLabel.text = "DEF"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 286)
    }
}
