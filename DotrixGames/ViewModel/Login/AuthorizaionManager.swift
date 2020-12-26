
import Foundation
import FBSDKLoginKit
import Combine
import SwiftUI
import Parse

struct MyUser {
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

    @Published private(set) var currentUser: MyUser? = nil

    private init() {}

    func login(with login: String, password: String) {
        PFUser.logInWithUsername(inBackground:login, password:password) { [weak self]
          (user: PFUser?, error: Error?) -> Void  in
            guard let self = self, let user = user else {
                print(error.debugDescription)
                return
            }
            self.currentUser = MyUser(pfUser: user)
        }
    }
    
    func login(userName: String, password: String) {
      PFUser.logInWithUsername(inBackground: userName, password: password) { [weak self]
        (user: PFUser?, error: Error?) -> Void in
        guard let self = self, let user = user else {
            print(error.debugDescription)
            return
        }
        self.currentUser = MyUser(pfUser: user)
        
      }
    }

    // FaceBook login
    func FBLoginUsingParse() {
        let permissions = ["public_profile","email"]
        PFFacebookUtils.logInInBackground(withReadPermissions: permissions) {
        (user: PFUser?, error: Error?) in
        if let user = user {
            if user.isNew {
            print("User signed up and logged in through Facebook!")
            print(user)
            
            } else {
            print("User logged in through Facebook!")
            print(user)
            self.currentUser = MyUser(pfUser: user)
            }
        } else {
            print("Uh oh. The user cancelled the Facebook login.")
        }
        }
    }

    func isUserLoggedIn() -> Bool {
        return currentUser != nil
    }
}

