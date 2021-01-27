//
//  SubscriptionListTableViewCell.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

protocol SubscriptionListTableViewCellDelegate: class {
    func didPressButton(in cell: UITableViewCell)
}

class SubscriptionListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    weak var delegate: SubscriptionListTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.setLineSpacing(lineHeightMultiple: 1.5)
        topView.layer.cornerRadius = 4
        topView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomView.layer.cornerRadius = 4
        bottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        applyShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20))
    }
    
    private func applyShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowRadius = 4
    }
    
    func configure(with viewModel: SubscriptionsListViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        descriptionLabel.text = viewModel.descritionText
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        delegate?.didPressButton(in: self)
    }
    
}

