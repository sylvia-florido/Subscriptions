//
//  PlanSelectorView.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

// Instead of using a delegate, this view is using an action block that it should receive upon initialization.
// Just to show another alternative to delegates.

import UIKit

class PlanSelectorView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var accentView: BorderView!
    @IBOutlet weak var planCardView: BorderView!
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var accentTextLabel: UILabel!
    @IBOutlet weak var planNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var equalMonthlyLabel: UILabel!
    
    var option: PlanOption = .left
    var radioButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        let nib = UINib(nibName: "PlanSelectorView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    func update(with viewModel: PlanSelectorViewModel) {
        option = viewModel.option
        accentView.isHidden = viewModel.accentText == nil
        planNameLabel.text = viewModel.plan
        priceLabel.text = viewModel.price
        periodLabel.text = viewModel.period
        equalMonthlyLabel.text = viewModel.equalMonthlyText
        setSelected(viewModel.selected)
    }
    
    private func setSelected(_ selected: Bool) {
        guard let accentColor = selected == true ? Colors.accentGreen  : Colors.mediumGray else { return }
        
        accentView.backgroundColor = accentColor
        accentView.borderColor = accentColor
        planCardView.borderColor = accentColor
        radioButton.tintColor = accentColor
    }
    
    @IBAction func selectRadioButton(_ sender: UIButton) {
        radioButtonAction?()
    }
}
