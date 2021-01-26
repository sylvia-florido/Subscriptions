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
        let controller = SubscriptionDetailsViewController()
//        let presenter = HomePresenter(with: controller)
//        let interactor = HomeInteractor(with: presenter, repository: repository)
//        controller.interactor = interactor
//        controller.router = self
        navigationController.pushViewController(controller, animated: true)
    }
}
