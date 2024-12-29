//
//  HomeViewController.swift
//  Reminder
//
//  Created by Mario Moraes on 27/12/24.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let contentView: HomeView
    public weak var flowDelegate: HomeFlowDelegate?
    
    init(contentView: HomeView, flowDelegate: HomeFlowDelegate){
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = false
        
        let logoutButton = UIBarButtonItem(image: UIImage(named: "logout"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutAction))

        logoutButton.tintColor = Colors.primaryRedBase
        navigationItem.rightBarButtonItem = logoutButton
        
    }
    
    @objc
    private func logoutAction(){
        
    }
    
    private func setup(){
        view.addSubview(contentView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        setupContentViewConstraints(contentView: contentView)
    }
    

}
