//
//  SubscriptionsCoordinator.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

protocol SubscriptionsCoordinatorProtocol: class {
    func start()
}


class SubscriptionsCoordinator: SubscriptionsCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var repository: SubscriptionsRepository = SubscriptionsRepository()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showListScene()
    }
    
    func showListScene() {
        let controller = SubscriptonsListViewController()
        controller.coordinator = self
        controller.repository = repository
        navigationController.pushViewController(controller, animated: true)
    }
    
    func showDetailsScene(with subscriptionDetails: SubscriptionDetails) {
        let controller = SubscriptionDetailsViewController()
        controller.subscription = subscriptionDetails
        navigationController.pushViewController(controller, animated: true)
    }
    
    func vipCleanArchitectureExample() {
//        let controller = HomeViewController()
//        let presenter = HomePresenter(with: controller)
//        let interactor = HomeInteractor(with: presenter, repository: repository, other data: OtherData)
//        controller.interactor = interactor
//        controller.router = self
//        navigationController.pushViewController(controller, animated: true)
    }
}
