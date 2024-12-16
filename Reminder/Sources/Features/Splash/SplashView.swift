//
//  SplashView.swift
//  Reminder
//
//  Created by Mario Moraes on 16/12/24.
//

import Foundation
import UIKit

class SplashView: UIView {
    
    private let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "logo")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let titleLogoLabel: UILabel = {
        let label = UILabel()
        label.text = "Remind"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = .systemRed
        
        self.addSubview(logoImage)
        self.addSubview(titleLogoLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints(){

        NSLayoutConstraint.activate([
            titleLogoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 24),
            titleLogoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -24),

            logoImage.trailingAnchor.constraint(equalTo: titleLogoLabel.leadingAnchor, constant: -8),
            logoImage.bottomAnchor.constraint(equalTo: titleLogoLabel.bottomAnchor),
            
        ])

        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
}
