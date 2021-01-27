//
//  SubscriptonsListViewController.swift
//  Subscriptions
//
//  Created by Me on 24/01/21.
//  Copyright © 2021 sflorido. All rights reserved.
//

import UIKit

class SubscriptonsListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinator: SubscriptionsCoordinator?
    var repository: SubscriptionsRepository?
    var subscriptions: [SubscriptionDetails] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let leftBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: SubscriptionsListStrings.leftButtonTitle, style: .plain, target: self, action: #selector(leftBarButtonPressed))
        button.setTitleTextAttributes([NSAttributedString.Key.font:  UIFont(name: "TTCommons-Medium", size: 20) ?? UIFont.systemFont(ofSize: 16, weight: .semibold)], for: UIControl.State.normal)
        return button
    }()
    
    let rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "icon_search"), style: .plain, target: self, action: #selector(rightBarButtonPressed))
        button.tintColor = Colors.mediumGray
        return button
    }()
    
    // MARK: - Lifecycle & Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupTableView()
        fetchData()
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setupTableView() {
        tableView.bounces = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(SubscriptionListTableViewCell.self)
    }
    
    // MARK: - Service Integration
    private func fetchData() {
        repository?.getSubscriptionsList(success: { [weak self] (subscriptionDetails) in
            self?.subscriptions = subscriptionDetails
        }, failure: { (errorMessage) in
            UIAlertController.show(from: self, title: "Erro de conexão", message: "Desculpe, não conseguimos encontrar assinaturas nessa momento. Tente novamente mais tarde.", preferredButtonTitle: "Entendi", handler: nil)
        })
    }
    private func fetchImageForSideBackground(for subscription: SubscriptionDetails, completion: @escaping (_ image: UIImage?)->()) {
        if let url = URL(string: subscription.backgroundSmall) {
            repository?.getImage(withURL: url, completion: { (image) in
                completion(image)
            })
        }
    }
    
    // MARK: - Actions
    @objc func leftBarButtonPressed(_ sender: Any?) {
    }
    
    @objc func rightBarButtonPressed(_ sender: Any?) {
    }
    
}

extension SubscriptonsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subscriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = subscriptions[indexPath.row]

        let viewModel = SubscriptionsListViewModel(with: model)
        let cell = tableView.dequeueCell(SubscriptionListTableViewCell.self, indexPath: indexPath)
        cell.configure(with: viewModel)
        cell.delegate = self
        let image = fetchImageForSideBackground(for: model) { (image) in
            cell.leftImageView?.image = image
        }
        return cell
    }
    
}

extension SubscriptonsListViewController: SubscriptionListTableViewCellDelegate {
    func didPressButton(in cell: UITableViewCell) {
        guard let index = tableView.indexPath(for: cell)?.row else {
            return
        }
        let subscriptionSelected = subscriptions[index]
        coordinator?.showDetailsScene(with: subscriptionSelected)
    }
}
