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
    //@ObservedObject var modelView =  EventListViewModel()
    @ViewBuilder var body: some View {
        
        if loginManager.isUserLoggedIn() {
            TabView {
                MenuView()
                //MapDisplayView()
                //createEvent(viewModel: modelView)
                //MainView()
                //signUpView()
                //MapDisplayView()
                //LoginView()
                //registrationForm()
            }
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
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
    //@State var modelView: EventListViewModel
    @State var modelView = EventListViewModel()
    
    var body: some View {
        VStack {
            //DisplayEventList(viewModel: modelView)
            MainView(viewModel: modelView)
        }
        .tabItem {
            Text("Menu")
            Image(systemName: "book")
        }
        VStack {
            MyEventsView(viewModel: modelView)
        }
        .tabItem {
            Text("MyEvents")
            Image(systemName: "person")
        }
    }
}
