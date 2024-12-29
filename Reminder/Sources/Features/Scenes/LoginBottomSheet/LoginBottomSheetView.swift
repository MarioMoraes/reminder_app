import Foundation
import UIKit

class LoginBottomSheetView: UIView {
    public weak var delegate: LoginBottomSheetViewDelegate?
    
    private let handleArea: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = Metrics.tiny
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
       let title = UILabel()
        title.text = "login.label.title".localized
        title.font = Typography.subHeading
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let hintEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "login.hint.email.text".localized
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailText: UITextField = {
        let text = UITextField()
        text.placeholder = "login.emailText.placeholder".localized
        text.autocapitalizationType = .none
        text.borderStyle = .bezel
        text.layer.borderColor = UIColor.gray.cgColor
        text.layer.cornerRadius = 5
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let hintPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "login.hint.password.text".localized
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordText: UITextField = {
        let text = UITextField()
        text.borderStyle = .line
        text.layer.borderColor = UIColor.gray.cgColor
        text.layer.cornerRadius = 5
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("login.button.title".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = Colors.primaryColor
        button.layer.cornerRadius = Metrics.medium
        button.addTarget(self, action: #selector(loginButtonDidTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.backgroundColor = .white
        self.layer.cornerRadius = Metrics.small
        
        self.addSubview(handleArea)
        self.addSubview(titleLabel)
        self.addSubview(hintEmailLabel)
        self.addSubview(emailText)
        self.addSubview(hintPasswordLabel)
        self.addSubview(passwordText)
        self.addSubview(loginButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            handleArea.topAnchor.constraint(equalTo: self.topAnchor, constant: Metrics.small),
            handleArea.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            handleArea.widthAnchor.constraint(equalToConstant: 40),
            handleArea.heightAnchor.constraint(equalToConstant: 6),
                        
            titleLabel.topAnchor.constraint(equalTo: handleArea.bottomAnchor, constant: Metrics.medium),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            
            hintEmailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.huge),
            hintEmailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),

            emailText.topAnchor.constraint(equalTo: hintEmailLabel.bottomAnchor, constant: Metrics.small),
            emailText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            emailText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            emailText.heightAnchor.constraint(equalToConstant: Metrics.heigth),
                        
            hintPasswordLabel.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: Metrics.medium),
            hintPasswordLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            
            passwordText.topAnchor.constraint(equalTo: hintPasswordLabel.bottomAnchor, constant: Metrics.small),
            passwordText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            passwordText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            passwordText.heightAnchor.constraint(equalToConstant: Metrics.heigth),
            
            loginButton.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: Metrics.huge),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.medium),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.medium),
            loginButton.heightAnchor.constraint(equalToConstant: Metrics.huge),
        ])
    }
    
    @objc
    private func loginButtonDidTapped() {
        let user = emailText.text ?? ""
        let password = passwordText.text ?? ""
        delegate?.sendDataLogin(user: user, password: password)
            
    }
}
