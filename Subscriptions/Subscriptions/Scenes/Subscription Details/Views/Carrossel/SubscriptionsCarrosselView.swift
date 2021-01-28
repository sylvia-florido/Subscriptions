//
//  SubscriptionsCarrosselView.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

protocol SubscriptionsCarrosselViewDelegate: class {
    func didSelectitem(at index: Int)
}


class SubscriptionsCarrosselView: UIView, NibInstantiable {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [SubscriptionsCarrosselViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var repository: SubscriptionsRepository?
    weak var delegate: SubscriptionsCarrosselViewDelegate?
    
    //MARK: - Lifecycle & Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        collectionView.dataSource = self
        collectionView.register(type: SubscriptionsCarrosselCollectionViewCell.self)
    }
    
    func update(with viewModel: [SubscriptionsCarrosselViewModel]) {
        items = viewModel
    }
}

extension SubscriptionsCarrosselView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(type: SubscriptionsCarrosselCollectionViewCell.self, for: indexPath)
        cell.update(with: viewModel)
        cell.delegate = self
        repository?.getImage(with: viewModel.imageUrl, completion: { (image) in
            if let image = image {
                cell.updateImage(with: image)
            }
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 286)
    }
}

extension SubscriptionsCarrosselView: SubscriptionsCarrosselCellDelegate {
    func didPressCarrosselCellButton(_ cell: SubscriptionsCarrosselCollectionViewCell) {
        if let index = collectionView.indexPath(for: cell) {
            delegate?.didSelectitem(at: index.row)
        }
    }
    
    
    
    
}
