//
//  SubscriptionDetailsViewController.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

class SubscriptionDetailsViewController: UIViewController {
    @IBOutlet weak var contentStackView: UIStackView!
    
    var repository: SubscriptionsRepository?
    var subscription: SubscriptionDetails? {
        didSet {
            if let subscription = subscription {
                configureViews(with: subscription)
            }
        }
    }
    var subscriptionsList: [SubscriptionDetails] = []
    var filteredList: [SubscriptionDetails] = []
    var selectedPlan: PlanOption = .right
    
    
    lazy var optionsView:SubscriptionOptionsView = {
        let view = SubscriptionOptionsView.initFromNib()
        view.delegate = self
        view.repository = repository
        return view
    }()
    
    lazy var descriptionView: SubscriptionDescriptionView = {
        let view = SubscriptionDescriptionView.initFromNib()
        view.repository = repository
        return view
    }()
    
    lazy var carrosselView: SubscriptionsCarrosselView = {
        let carrossel = SubscriptionsCarrosselView.initFromNib()
        carrossel.repository = repository
        carrossel.delegate = self
        return carrossel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let statusBarView = UIView(frame: statusBarFrame)
        self.view.addSubview(statusBarView)
        statusBarView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    }
    
    private func setupViews() {
        guard let subscription = self.subscription else { return }
        contentStackView.addArrangedSubview(optionsView)
        contentStackView.addArrangedSubview(descriptionView)
        contentStackView.addArrangedSubview(carrosselView)

        configureViews(with: subscription)
    }
    
    private func configureViews(with subscription: SubscriptionDetails) {
        setupOptionsView(with: subscription)
        setupDescriptionView(with: subscription)
        setupCarrosselView(with: subscriptionsList)
    }
    
    private func setupOptionsView(with subscription: SubscriptionDetails) {
        // Challenge - idealmente os valores e textos dos planos teriam que vir de um serviço, não seria bom deixar fixo no front. Mocando aqui só para o teste.
        // Mesma coisa para o disclaimer que está fixo no momento.
        let leftPlan = PlanSelectorViewModel(option: .left, accentText: nil, plan: "MENSAL", price: "R$ 9,99", period: "por mês", equalMonthlyText: nil, selected: self.selectedPlan == .left)
        let rightPlan = PlanSelectorViewModel(option: .right, accentText: "50% de desconto", plan: "ANUAL", price: "R$ 59,99", period: "por ano", equalMonthlyText: "(= R$ 4,99/mês)", selected: self.selectedPlan == .right)
        
        let optionsViewModel = SubscriptionOptionsViewModel(subscriptionName: subscription.name, largeBackgroundUrlString: subscription.backgroundLarge, strategistImage: nil, strategistAdvice: subscription.shortDescription, disclaimer: nil, leftPlanViewModel: leftPlan, rightPlanViewModel: rightPlan)
        optionsView.update(with: optionsViewModel)
    }
    
    private func setupDescriptionView(with subscription: SubscriptionDetails) {
        let viewModel = SubscriptionDescriptionViewModel.viewModel(with: subscription)
        descriptionView.update(with: viewModel)
    }
    
    private func setupCarrosselView(with subscriptionsList: [SubscriptionDetails]) {
        filteredList = subscriptionsList.filter({ $0.identifier != subscription?.identifier})
        
        let carrosselViewModel = filteredList.map { (subscription) -> SubscriptionsCarrosselViewModel in
            return SubscriptionsCarrosselViewModel(with: subscription)
        }
        carrosselView.update(with: carrosselViewModel)
    }
    
}

extension SubscriptionDetailsViewController: SubscriptionOptionsViewDelegate {
    func didSelectPlan(option: PlanOption) {
        self.selectedPlan = option
        optionsView.toggleSelectedPlan(option: option)
    }
    
    func didClickSubscribe() {
        UIAlertController.show(from: self, title: "Assine", message: "Você clicou no botão Assine Agora.", preferredButtonTitle: "Ok", handler: nil)
    }
}

extension SubscriptionDetailsViewController: SubscriptionsCarrosselViewDelegate {
    func didSelectitem(at index: Int) {
        guard subscriptionsList.count > index else { return }
        subscription = filteredList[index]
    }
}
