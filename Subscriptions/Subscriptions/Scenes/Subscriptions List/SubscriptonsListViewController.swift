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
            filteredResults = subscriptions
        }
    }
    var filteredResults: [SubscriptionDetails] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    lazy var leftBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: SubscriptionsListStrings.leftButtonTitle, style: .plain, target: self, action: #selector(leftBarButtonPressed(_:)))
        button.setTitleTextAttributes([NSAttributedString.Key.font:  UIFont(name: "TTCommons-Medium", size: 20) ?? UIFont.systemFont(ofSize: 16, weight: .semibold)], for: UIControl.State.normal)
        return button
    }()

    lazy var rightBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "icon_search"), style: .plain, target: self, action: #selector(rightBarButtonPressed(_:)))
        button.tintColor = Colors.mediumGray
        return button
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        definesPresentationContext = true
        searchController.searchBar.barStyle = .blackTranslucent
        searchController.searchBar.tintColor = Colors.mediumGray
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = true

        return searchController
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
        navigationItem.hidesSearchBarWhenScrolling = false
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
        // Ofertas
        print("OFertas")
    }
    
    @objc func rightBarButtonPressed(_ sender: Any?) {
        // Search
        print("Seacrh")
        
        showSearchBar(searchBar: searchController.searchBar)
    }
    
    func showSearchBar(searchBar : UISearchBar) {
        navigationItem.searchController = searchController
        searchBar.becomeFirstResponder()
        UIView.animate(withDuration: 0.5, animations: {
            searchBar.alpha = 1
        }, completion: { finished in
        })
    }

    func hideSearchBar( searchBar : UISearchBar) {
        searchBar.resignFirstResponder()
        UIView.animate(withDuration: 0.3, animations: {
            searchBar.alpha = 0
        }, completion: { finished in
            self.navigationItem.searchController = nil
        })
     }
}

extension SubscriptonsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = filteredResults[indexPath.row]

        let viewModel = SubscriptionsListViewModel(with: model)
        let cell = tableView.dequeueCell(SubscriptionListTableViewCell.self, indexPath: indexPath)
        cell.configure(with: viewModel)
        cell.delegate = self
        fetchImageForSideBackground(for: model) { (image) in
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
        coordinator?.showDetailsScene(with: subscriptionSelected, subscriptionsList: subscriptions)
    }
}

extension SubscriptonsListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            filterContentForSearchText(text)
        } else {
            filteredResults = subscriptions
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredResults = subscriptions.filter { (viewModel) -> Bool in
            return viewModel.name.lowercased().contains(searchText.lowercased())
        }
//        listView.viewModel = filteredResults
    }
    
    //MARK: UISearchBarDelegate
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        hideSearchBar(searchBar: searchBar)
    }
}
