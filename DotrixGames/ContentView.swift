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
                MenuView()
                MapDisplayView()
                createEvent()
                //signUpView()
                //MapDisplayView()
                //LoginView()
                //registrationForm()
            }
            //.edgesIgnoringSafeArea(.all)
            //.statusBar(hidden: true)
        }
        else {
            LoginView()
                    .environmentObject(AuthorizaionManager.shared)
                    .edgesIgnoringSafeArea(.all)
                    .statusBar(hidden: true)
        }
    }
}


struct MenuView: View {
    
    var body: some View {
        VStack {
            DisplayEventList()
        }
        .tabItem {
            Text("Menu")
            Image(systemName: "book")
        }
    }
}
