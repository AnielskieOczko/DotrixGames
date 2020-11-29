//
//  ContentView.swift
//  DotrixGames
//
//  Created by Rafal on 21/11/2020.
//  Copyright © 2020 RafalDX. All rights reserved.
//

import SwiftUI
import Combine
import MapKit

struct ContentView: View {
    
    var body: some View {
        
        LoginView()
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
        //TabView {
            //signUpView()
            //MapDisplayView()
            //LoginView()
            
            //createEvent()
        //}
        
    }
}




//class LoginData {
//    var userName = ""
//    var password = ""
//}
//
//struct loginButton: View {
//    var body: some View {
//        Text("LOGIN")
//            .font(.headline)
//            .foregroundColor(Color.white)
//            .padding()
//            .frame(width: 100, height: 50)
//            .background(Color.green)
//            .cornerRadius(5)
//
//    }
//}
//
//struct loginView: View {
//    @State var userName = ""
//    @State var password = ""
//
//    var body: some View {
//        VStack {
//            TextField("userName", text: $userName)
//            SecureField("password", text: $password)
//
//            Button(action: { print("login button tapped") }) {
//                loginButton()
//            }
//        }
//
//    }
//}
//
//
//
//

/*
// code from Facebook (where to paste^^)
// Swift
//
// Add this to the header of your file, e.g. in ViewController.swift
import FBSDKLoginKit
// Add this to the body
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)

        // Swift

        override func viewDidLoad() {
            super.viewDidLoad()

            if let token = AccessToken.current,
                !token.isExpired {
                // User is logged in, do work such as go to next view controller.
            }
        }
            }
}
 

 // Swift
 //
 // Extend the code sample from 6a. Add Facebook Login to Your Code
 // Add to your viewDidLoad method:
 loginButton.permissions = ["public_profile", "email"]

*/







