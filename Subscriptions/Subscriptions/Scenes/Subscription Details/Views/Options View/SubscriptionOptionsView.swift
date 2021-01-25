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
    
    @IBOutlet weak var strategistImageView: UIImageView!
    @IBOutlet weak var strategicAdviceLabel: UILabel!
    @IBOutlet weak var bottomDisclaimerLabel: UILabel!
    
    @IBOutlet weak var leftPlanSelector: PlanSelectorView!
    @IBOutlet weak var rightPlanSelector: PlanSelectorView!

    weak var delegate: SubscriptionOptionsViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        strategicAdviceLabel.setLineSpacing(lineHeightMultiple: 1.5)
        bottomDisclaimerLabel.setLineSpacing(lineHeightMultiple: 1.5)
        
        leftPlanSelector.backgroundColor = .clear
        rightPlanSelector.backgroundColor = .clear
        
        leftPlanSelector.radioButtonAction = leftPlanSelectionAction
        rightPlanSelector.radioButtonAction = rightPlanSelectionAction
    }
    
    func update(with viewModel: SubscriptionOptionsViewModel) {
        strategistImageView.image = viewModel.strategistImage
        strategicAdviceLabel.text = viewModel.strategistAdvice
        bottomDisclaimerLabel.text = viewModel.disclaimer
        leftPlanSelector.update(with: viewModel.leftPlanViewModel)
        rightPlanSelector.update(with: viewModel.rightPlanViewModel)
    }
    
    func updatePlanSelector(option: PlanOption, with viewModel: PlanSelectorViewModel) {
        switch option {
        case .left:
            leftPlanSelector.update(with: viewModel)
        case .right:
            rightPlanSelector.update(with: viewModel)
        }
    }
    
    
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