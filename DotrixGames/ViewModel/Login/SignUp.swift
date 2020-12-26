//
//  LoginSignUp.swift
//  DotrixGames
//
//  Created by Rafal on 20/12/2020.
//  Copyright © 2020 RafalDX. All rights reserved.
//

import SwiftUI
import FBSDKLoginKit
import Combine
import Parse





class User: ObservableObject {
    
    var currentUser = PFUser()
    
    func isUserLogged() -> Bool {
        return currentUser.username != nil
    }
}


// class to store sign up data during sign up
class registrationData: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    var userName = "" { didSet { update() } }
    var password = "" { didSet { update() } }
    var reEnteredPassword = "" { didSet { update() } }
    var emailAdress = "" { didSet { update() }}
    
    func update() {
        didChange.send(())
    }
}

// sign up function
// uses registrationData class
func signUpUsingParse(regForm: registrationData) {

    let user = PFUser()
    
    user.username = regForm.emailAdress
    user.password = regForm.password
    user.email = regForm.emailAdress
  // other fields can be set just like with PFObject
  user["phone"] = "415-392-0202"

  user.signUpInBackground {
    (succeeded: Bool, error: Error?) -> Void in
    if let error = error {
      let errorString = error.localizedDescription
      // Show the errorString somewhere and let the user try again.
        print(errorString)
    } else {
      // Hooray! Let them use the app now.
        print("sign up done for user: ")
    }
  }
}

// FaceBook login
/*
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
        }
    } else {
        print("Uh oh. The user cancelled the Facebook login.")
    }
    }
}

func login(userName: String, password: String) {
    PFUser.logInWithUsername(inBackground: userName, password: password) {
      (user: PFUser?, error: Error?) -> Void in
      if user != nil {
        // Do stuff after successful login.
        print("logged in")
        print(user!)
        
      } else {
        // The login failed. Check error to see why.
        print(error.debugDescription)
      }
    }
  }
*/
