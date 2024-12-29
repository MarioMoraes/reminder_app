import Foundation
import UIKit

class LoginBottomSheetViewController: UIViewController {
    let loginViewModel = LoginBottomSheetViewModel()
    let contentView: LoginBottomSheetView
    
    public weak var flowDelegate: LoginBottomSheetFlowDelegate?
    
    var handleAreaHeigth: CFloat = 40.0
    
    init(contentView: LoginBottomSheetView, flowDelegate: LoginBottomSheetFlowDelegate){
        
        self.contentView = LoginBottomSheetView()
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
        
        self.bindViewModel()
        
        setupUI()
        setupGesture()
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        let heigthConstraint: () = contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        
    }
    
    private func setupGesture() {
        
    }
    
    private func handlePanGesture() {
        
    }
    
    func animateShow(completion: (() -> Void)? = nil) {
        self.view.layoutIfNeeded()
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = .identity
            self.view.layoutIfNeeded()
        }) {
            _ in completion?()
        }
    }
    
    private func bindViewModel() {
        self.loginViewModel.successResult = { [weak self] user in
            self?.presentSaveLoginAlert(email: user)
        }
        self.loginViewModel.errorResult = { [weak self] error in
            self?.presentErrorLogin(message: error)
        }
    }
    
    private func presentErrorLogin(message: String){
        let alertController = UIAlertController(title: "Erro na Autenticação",
                                                message: message,
                                                preferredStyle: .alert)

        let closeAction = UIAlertAction(title: "Tentar Novamente", style: .cancel)
        
        alertController.addAction(closeAction)
        self.present(alertController, animated: true)
        
    }
    
    
    private func presentSaveLoginAlert(email: String){
        let alertController = UIAlertController(title: "Salvar Dados do Login",
                                                message: "Deseja salvar os dados de login para os próximos acessos?",
                                                preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Salvar",
                                       style: .default){ _ in
            
            let user = User(email: email, isUserSaved: true)
            UserDefaultManager.saveUser(user: user)
            self.flowDelegate?.navigateToHome()
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .default) {_ in
            self.flowDelegate?.navigateToHome()
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
        
    }
}

extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate {
    func sendDataLogin(user: String, password: String) {
        loginViewModel.doAuth(user: user, password: password)
    }
}
