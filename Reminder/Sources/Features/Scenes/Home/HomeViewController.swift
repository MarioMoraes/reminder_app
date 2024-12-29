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
    let viewModel: HomeViewModel
    public weak var flowDelegate: HomeFlowDelegate?
    
    init(contentView: HomeView, flowDelegate: HomeFlowDelegate){
        self.contentView = contentView
        self.viewModel = HomeViewModel()
        self.flowDelegate = flowDelegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setup()
        checkForExistingData()
    }
    
    private func setupNavigationBar(){
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        
        let logoutButton = UIBarButtonItem(image: UIImage(named: "log-out"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutAction))

        logoutButton.tintColor = Colors.primaryRedBase
        logoutButton.width = 15
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    @objc
    private func logoutAction(){
        UserDefaultManager.removeUser()
        self.flowDelegate?.logout()
    }
    
    private func setup(){
        view.addSubview(contentView)
        
        contentView.delegate = self
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        setupContentViewConstraints(contentView: contentView)
    }
    
    private func checkForExistingData() {
        if UserDefaultManager.loadUser() != nil {
            contentView.nameTextField.text = UserDefaultManager.loadUserName()
        }
        if (UserDefaultManager.loadUserImage() != nil) {
            contentView.profileImage.image = UserDefaultManager.loadUserImage()
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    func didSavedProfileImage() {
       
    }
    
    func didTapProfileImage() {
        selectProfileImage()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            contentView.profileImage.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            contentView.profileImage.image = originalImage
        }
        dismiss(animated: true)
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
