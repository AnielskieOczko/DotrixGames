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

    @EnvironmentObject var loginManager: AuthorizaionManager

    @ViewBuilder var body: some View {

        if loginManager.isUserLoggedIn() {
            TabView {
                signUpView()
                MapDisplayView()
                LoginView()
                registrationForm()
                createEvent()
            }
        } else {
            LoginView()
                .environmentObject(AuthorizaionManager.shared)
                .edgesIgnoringSafeArea(.all)
                .statusBar(hidden: true)
        }
    }
}
