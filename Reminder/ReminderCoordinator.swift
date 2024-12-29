import Foundation
import UIKit

class ReminderCoordinator: LoginBottomSheetFlowDelegate {
    // MARK: - Properties
    private var navigationController: UINavigationController?
    private var viewControllersFactory: ViewControllersFactoryProtocol
    
    // MARK: - Init
    public init() {
        self.viewControllersFactory = ViewControllersFactory()
    }
    
    // MARK: - StartFlow
    func start() -> UINavigationController? {
        let startViewController = viewControllersFactory.makeSplashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

// MARK: - Login
extension ReminderCoordinator: LoginBottomSheetViewDelegate {
    func sendDataLogin(user: String, password: String) {
    }
    
    func navigateToHome(){
        self.navigationController?.dismiss(animated: false)
        let viewController = viewControllersFactory.makeHomeViewController(flowDelegate: self)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Splash
extension ReminderCoordinator: SplashFlowDelegate {
    func openLoginBottomSheet() {
        let loginBottomSheet = viewControllersFactory.makeLoginBottomSheetViewController(flowDelegate: self)
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        navigationController?.present(loginBottomSheet, animated: false){
            loginBottomSheet.animateShow()
        }

        func navigateToHome() {
            self.navigationController?.dismiss(animated: false)
            let viewController = viewControllersFactory.makeHomeViewController(flowDelegate: self)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

// MARK: - Home
extension ReminderCoordinator: HomeFlowDelegate {
    func navigateToRecipes() {
        
    }
    
    func logout() {
        self.navigationController?.popViewController(animated: true)
        self.openLoginBottomSheet()
    }
}
