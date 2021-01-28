//
//  SubscriptionOptionsView.swift
//  Subscriptions
//
//  Created by Me on 25/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

protocol SubscriptionOptionsViewDelegate: class {
    func didSelectPlan(option: PlanOption)
    func didClickSubscribe()
}

class SubscriptionOptionsView: UIView, NibInstantiable {
    
    @IBOutlet weak var largeAuthorImageView: UIImageView!
    @IBOutlet weak var subscriptionNameLabel: UILabel!
    @IBOutlet weak var authorAdviceLabel: UILabel!
    @IBOutlet weak var bottomDisclaimerLabel: UILabel!
    @IBOutlet weak var leftPlanSelector: PlanSelectorView!
    @IBOutlet weak var rightPlanSelector: PlanSelectorView!

    var repository: SubscriptionsRepository?
    weak var delegate: SubscriptionOptionsViewDelegate?
    
    //MARK: - Lifecycle & Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        largeAuthorImageView.applyGradient(colors: [UIColor.clear.cgColor, Colors.customTitle?.cgColor ?? UIColor.black.cgColor], locations: [0.0, 1.0], direction: .topToBottom)
    }
    
    
    func setup() {
        authorAdviceLabel.setLineSpacing(lineHeightMultiple: 1.5, alignment: .center)
        bottomDisclaimerLabel.setLineSpacing(lineHeightMultiple: 1.5, alignment: .center)       
        
        leftPlanSelector.backgroundColor = .clear
        rightPlanSelector.backgroundColor = .clear
        
        leftPlanSelector.radioButtonAction = leftPlanSelectionAction
        rightPlanSelector.radioButtonAction = rightPlanSelectionAction
    }
    
    //MARK: - Update display
    func update(with viewModel: SubscriptionOptionsViewModel) {
        subscriptionNameLabel.text = viewModel.subscriptionName
        largeAuthorImageView.image = viewModel.strategistImage
        authorAdviceLabel.text = viewModel.strategistAdvice
        bottomDisclaimerLabel.text = viewModel.disclaimer
        leftPlanSelector.update(with: viewModel.leftPlanViewModel)
        rightPlanSelector.update(with: viewModel.rightPlanViewModel)
        repository?.getImage(with: viewModel.largeBackgroundUrlString, completion: { [weak self] (image) in
            if let image = image {
                self?.updateImage(with: image)
            }
        })
    }
    
    func updateImage(with image: UIImage) {
        largeAuthorImageView.image = image
    }
    
    func toggleSelectedPlan(option: PlanOption) {
        leftPlanSelector.setSelected(option == .left)
        rightPlanSelector.setSelected(option == .right)

    }
    
    // MARK: - Actions
    private func leftPlanSelectionAction() {
        delegate?.didSelectPlan(option: .left)
    }
    
    private func rightPlanSelectionAction() {
        delegate?.didSelectPlan(option: .right)
    }
    
    @IBAction func subscribeButton(_ sender: UIButton) {
        delegate?.didClickSubscribe()
    }
}
