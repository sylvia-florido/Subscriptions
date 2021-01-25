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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let test = SubscriptionOptionsView.initFromNib()
        test.delegate = self
        let test1 = SubscriptionOptionsView.initFromNib()
        contentStackView.addArrangedSubview(test)
        
        contentStackView.addArrangedSubview(test1)
        print("")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let statusBarFrame = UIApplication.shared.statusBarFrame
        let statusBarView = UIView(frame: statusBarFrame)
        self.view.addSubview(statusBarView)
        statusBarView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    }


}

extension SubscriptionDetailsViewController: SubscriptionOptionsViewDelegate {
    func didSelectPlan(option: PlanOption) {
        // update plans selection view
        print("Did selecto plan option: \(option.rawValue)")
    }
    
    func didClickSubscribe() {
        // proccess subscription
        print("subscribe")
    }
    
}
