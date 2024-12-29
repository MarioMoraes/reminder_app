//
//  ViewControllerExtension.swift
//  Reminder
//
//  Created by Mario Moraes on 27/12/24.
//
import UIKit

extension UIViewController {
    func setupContentViewConstraints(contentView: UIView){
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
    }
    
}
