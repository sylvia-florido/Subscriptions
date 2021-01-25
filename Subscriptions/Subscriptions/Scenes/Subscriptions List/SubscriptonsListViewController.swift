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
    
    let leftBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: SubscriptionsListStrings.leftButtonTitle, style: .plain, target: self, action: #selector(leftBarButtonPressed))
        button.setTitleTextAttributes([NSAttributedString.Key.font:  UIFont(name: "TTCommons-Medium", size: 20) ?? UIFont.systemFont(ofSize: 16, weight: .semibold)], for: UIControl.State.normal)
        return button
    }()
    
    let rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "icon_search"), style: .plain, target: self, action: #selector(rightBarButtonPressed))
        button.tintColor = Colors.navbarIcon
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setupTableView()
    }
    
    override func configureNavigationBar() {
        super.configureNavigationBar()
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    fileprivate func setupTableView() {
        tableView.bounces = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(SubscriptionListTableViewCell.self)
    }
    
    @objc func leftBarButtonPressed(_ sender: Any?) {
    }
    
    @objc func rightBarButtonPressed(_ sender: Any?) {
    }
    
}

extension SubscriptonsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cellViewModel = viewModel[indexPath.row]
        let cell = tableView.dequeueCell(SubscriptionListTableViewCell.self, indexPath: indexPath)
//        cell.configWith(viewModel: cellViewModel)
//        cell.delegate = self
        return cell
    }
    
    
}
