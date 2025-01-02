//
//  HomeView.swift
//  Reminder
//
//  Created by Mario Moraes on 27/12/24.
//

import Foundation
import UIKit

class HomeView: UIView, UITextFieldDelegate {
    weak public var delegate: HomeViewDelegate?
        
    let profileBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray600
        
        return view
    }()
    
    let contentBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray800
        view.layer.cornerRadius = Metrics.huge
        view.layer.masksToBounds = true
        
        return view
    }()
    
    let profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Metrics.circular
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.input
        label.textColor = Colors.gray200
        label.text = "home.welcomeLabel.text".localized

        return label
    }()
    
    let nameTextField: UITextField = {
        let label = UITextField()
        label.font = Typography.heading
        label.placeholder = "Insira Seu Nome"
        label.returnKeyType = .done
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray100

        return label
    }()
    
    let feedBackButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.gray100
        button.setTitle("home.feedBackButton.title".localized, for: .normal)
        button.setTitleColor(Colors.gray800, for: .normal)
        button.layer.cornerRadius = Metrics.small
        
        return button
    }()
    
    // Component ButtonHomeView
    let prescription: ButtonHomeView = {
       let button = ButtonHomeView(icon: UIImage(named: "Paper"),
                                   title: "Minhas Receitas",
                                   description: "Acompanhe os medicamentos e gerencie lembretes")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Component ButtonHomeView
    let newPrescription: ButtonHomeView = {
       let button = ButtonHomeView(icon: UIImage(named: "Pills"),
                                   title: "Nova Receita",
                                   description: "Cadastre novos lembretes de receitas")
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = Colors.gray600

        self.addSubview(profileBackground)
        profileBackground.addSubview(profileImage)
        profileBackground.addSubview(welcomeLabel)
        profileBackground.addSubview(nameTextField)
        
        self.addSubview(contentBackground)
        contentBackground.addSubview(feedBackButton)
        contentBackground.addSubview(prescription)
        contentBackground.addSubview(newPrescription)
                
        setupConstraints()
        profileImageGesture()
    }
    
    private func setupConstraints(){
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileBackground.topAnchor.constraint(equalTo: topAnchor),
            profileBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            profileBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            profileBackground.heightAnchor.constraint(equalToConstant: Metrics.profileBackground),
            
            contentBackground.topAnchor.constraint(equalTo: profileBackground.bottomAnchor),
            contentBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentBackground.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            profileImage.topAnchor.constraint(equalTo: profileBackground.topAnchor, constant: 80),
            profileImage.leadingAnchor.constraint(equalTo: profileBackground.leadingAnchor, constant: Metrics.medium),
            profileImage.heightAnchor.constraint(equalToConstant: Metrics.profileImage),
            profileImage.widthAnchor.constraint(equalToConstant: Metrics.profileImage),
            
            welcomeLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: Metrics.welcomeLabel),
            welcomeLabel.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 4),
            nameTextField.leadingAnchor.constraint(equalTo: welcomeLabel.leadingAnchor),
            
            feedBackButton.bottomAnchor.constraint(equalTo: contentBackground.bottomAnchor, constant: -Metrics.medium),
            feedBackButton.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
            feedBackButton.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
            feedBackButton.heightAnchor.constraint(equalToConstant: Metrics.huge),
            
            prescription.topAnchor.constraint(equalTo: contentBackground.topAnchor, constant: Metrics.huge),
            prescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            prescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            prescription.heightAnchor.constraint(equalToConstant: 112),
            
            newPrescription.topAnchor.constraint(equalTo: prescription.bottomAnchor, constant: Metrics.medium),
            newPrescription.leadingAnchor.constraint(equalTo: contentBackground.leadingAnchor, constant: Metrics.medium),
            newPrescription.trailingAnchor.constraint(equalTo: contentBackground.trailingAnchor, constant: -Metrics.medium),
            newPrescription.heightAnchor.constraint(equalToConstant: 112),

        ])
    }
    
    private func profileImageGesture(){
        let imageTapped = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImage.addGestureRecognizer(imageTapped)
    }
    
    @objc
    private func profileImageTapped() {
        delegate?.didTapProfileImage()
    }
    
    private func setupTextField() {
        nameTextField.addTarget(self,
                            action: #selector(nameLabelEditingDidEnd),
                            for: .editingDidEnd)
        nameTextField.delegate = self
        
    }
    
    @objc
    private func nameLabelEditingDidEnd(){
        let name = nameTextField.text ?? ""
        UserDefaultManager.saveUserName(user: name)
    }
}

extension HomeView: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let name = nameTextField.text ?? ""
        UserDefaultManager.saveUserName(user: name)
        return true
    }
}
	
