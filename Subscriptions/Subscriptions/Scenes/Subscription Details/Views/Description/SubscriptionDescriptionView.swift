//
//  SubscriptionDescriptionView.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit


class SubscriptionDescriptionView: UIView, NibInstantiable {
    
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var authorProfileImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var featuresStackView: UIStackView!
    @IBOutlet weak var featuresSectionStackView: UIStackView!
    
    var repository: SubscriptionsRepository?
    
    //MARK: - Lifecycle & Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        aboutLabel.setLineSpacing(lineHeightMultiple: 1.5)
        authorProfileImageView.layer.cornerRadius = authorProfileImageView.frame.height/2
    }
    
    func update(with viewModel: SubscriptionDescriptionViewModel) {
        aboutLabel.text = viewModel.about
        authorNameLabel.text = viewModel.authorName
        repository?.getImage(with: viewModel.smallProfileUrlString, completion: { [weak self] (image) in
            if let image = image {
                self?.updateImage(with: image)
            }
        })
        guard let featuers = viewModel.featues else {
            // hide features section, because it's empty
            featuresSectionStackView.isHidden = true
            return
        }
        showSection(with: featuers)
    }
    
    func updateImage(with image: UIImage) {
        authorProfileImageView.image = image
    }
    
    private func showSection(with features: [SummaryViewModel]) {
        cleanView()
        for viewModel in features {
            let summaryView = SummaryView()
            summaryView.update(with: viewModel)
            featuresStackView.addArrangedSubview(summaryView)
        }
        featuresSectionStackView.isHidden = false
    }
    
    private func cleanView() {
        featuresStackView.subviews.forEach { (subview) in
            featuresStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
    }
    
    
    
}
