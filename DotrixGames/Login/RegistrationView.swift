//
//  RegistrationView.swift
//  DotrixGames
//
//  Created by Rafal on 26/11/2020.
//  Copyright © 2020 RafalDX. All rights reserved.
//

import SwiftUI
import Combine
import Parse

struct signUpView: View {
    
    var body: some View {
        VStack {
            registrationForm()
        }
    }
}

// class to store sign up data during sign up
class registrationData: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    var userName = "" { didSet { update() } }
    var password = "" { didSet { update() } }
    var emailAdress = "" { didSet { update() }}
    
    func update() {
        didChange.send(())
    }
}

// sign up button used in registration form
struct signUpButton: View {
    var body: some View {
        VStack{
            Text("Sign Up").font(.body)
            Image(systemName: "person.fill")
        }
        .frame(width: 100, height: 50, alignment: .center)
        .foregroundColor(.gray)
        .background(Color.black)
        .padding(.all)
        .cornerRadius(16)
    }
}

// registration form used to collect data from user
// uses registrationData class
struct registrationForm: View {
    @ObservedObject var regForm = registrationData()
    
    var body: some View {
        VStack {
            Form {
                TextField("user name", text: $regForm.userName)
                TextField("email adress", text: $regForm.emailAdress)
                SecureField("password", text: $regForm.password)
            }
            .navigationBarTitle("Create your account:").font(.largeTitle)
            
            Button(action: {
                signUp(regForm: self.regForm)
            }) {
                signUpButton()
            }
        }
    .navigationBarTitle("Create your account:")
    }
}

// sign up function
// uses registrationData class
func signUp(regForm: registrationData) {
    let user = PFUser()
    
    user.username = regForm.userName
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
        print("sign up done")
    }
  }
}
