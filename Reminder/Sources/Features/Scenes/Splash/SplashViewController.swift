import Foundation
import UIKit

class SplashViewController: UIViewController {
    let contentView: SplashView
    public weak var flowDelegate: SplashFlowDelegate?
    
    init(contentView: SplashView, flowDelegate: SplashFlowDelegate){
        
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        
        // Check User is Logged\
        startBreathingAnimation()
        
        setup()

    }
    
    private func decideNavigationFlow() {
        if let user = UserDefaultManager.loadUser(), user.isUserSaved {
            flowDelegate?.navigateToHome()
        } else {
            showLoginBottomSheet()
        }
    }
    
    private func setup() {
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.primaryColor
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        setupContentViewConstraints(contentView: contentView)
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginBottomSheet))
        self.view.addGestureRecognizer(tapGesture)
    }

    
    @objc
    private func showLoginBottomSheet() {
        aninateLogoUp()
        self.flowDelegate?.openLoginBottomSheet()
    }
}

// MARK: - Animation
extension SplashViewController {
    private func startBreathingAnimation(){
        UIView.animate(withDuration: 2.0,
                       delay: 0.0,
                       animations: {
            self.contentView.logoImage.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { _ in
            self.decideNavigationFlow()
        })
    }
    
    private func aninateLogoUp(){
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveEaseOut],
                       animations: {
            self.contentView.logoImage.transform = self.contentView.logoImage.transform.translatedBy(x: 0, y: -150)
        })
    }
}
