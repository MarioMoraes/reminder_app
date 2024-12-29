import Foundation
import UIKit

protocol LoginBottomSheetViewDelegate: AnyObject {
    func sendDataLogin(user: String, password: String)
}
