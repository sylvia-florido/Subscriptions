//
//  SubscriptionDetailsCollectionViewCell.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

protocol SubscriptionsCarrosselCellDelegate: class {
    func didPressCarrosselCellButton(_ cell: SubscriptionsCarrosselCollectionViewCell)
}

class SubscriptionsCarrosselCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: SubscriptionsCarrosselCellDelegate?

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.setLineSpacing(lineHeightMultiple: 1.5)
        applyRoundedImage()
        applyShadow()
    }
    
    private func applyRoundedImage() {
        imageView.layer.cornerRadius = 4
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func applyShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius = 2
    }
    
    func update(with viewModel: SubscriptionsCarrosselViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
    func updateImage(with image: UIImage) {
        imageView.image = image
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.didPressCarrosselCellButton(self)
    }
}
