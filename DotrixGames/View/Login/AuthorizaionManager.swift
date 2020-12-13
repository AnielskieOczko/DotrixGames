import Foundation
import FacebookLogin
import FacebookCore
import Combine
import SwiftUI
import Parse

struct User {
    var login: String {
        return pfUser.username ?? ""
    }
    private let pfUser: PFUser

    init(pfUser: PFUser) {
        self.pfUser = pfUser
    }
}

class AuthorizaionManager: ObservableObject {
    private let loginManager = LoginManager()

    static let shared = AuthorizaionManager()

    @Published private(set) var currentUser: User? = nil

    private init() {}

    func login(with login: String, password: String) {
        PFUser.logInWithUsername(inBackground:login, password:password) { [weak self]
          (user: PFUser?, error: Error?) -> Void  in
            guard let self = self, let user = user else {
                print(error.debugDescription)
                return
            }
            self.currentUser = User(pfUser: user)
        }
    }

    func facebookLogin() {
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: nil) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in! \(grantedPermissions) \(declinedPermissions) \(accessToken)")
                GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name"]).start(completionHandler: { (connection, result, error) -> Void in
                    if (error == nil){
                        let fbDetails = result as! NSDictionary
                    }
                })
            }
        }
    }

    func isUserLoggedIn() -> Bool {
        return currentUser != nil
    }
}
