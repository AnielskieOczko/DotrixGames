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
        TabView {
            mapDisplayView()
            //loginView()
            //createEvent()
        }
        
    }
}

struct mapDisplayView: View {
    @State private var locations = [MKPointAnnotation]()
    @State private var newPinCoordinate = CLLocationCoordinate2D()
    
    var body: some View {
        ZStack {
            mapView(annotations: locations, newPinCoordinate: $newPinCoordinate)
                .edgesIgnoringSafeArea(.all)
                    VStack {
                Spacer()
                HStack {
                    Spacer()
                    // button to add new annotation on map
                    // this button will be replaced
                    // long tap gesture will trigger adding new annotation to map
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        // to add possibility to custom title, subtitle and others by user
                        newLocation.title = "Miasto Dotrixa"
                        newLocation.subtitle = "miasto"
                        newLocation.coordinate = self.newPinCoordinate
                        self.locations.append(newLocation)
                    }) {
                        Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(Color.white)
                        .font(Font.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
            }
        }
        .tabItem {
            Text("Map")
            Image(systemName:"map.fill")
        }
    }
}

struct addLocationButton: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(Color.white)
                    .font(Font.title)
                    .clipShape(Circle())
                    .padding(.trailing)
            }
        }
    }
}

// describes event object
class EventList: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    var eventName = "" { didSet{ update() } }
    static let eventTypes = ["casual","tournament"]
    var type = 0 { didSet{ update() } }
    
    @Published var minPlayerNumber = 0 { didSet{ update() } }
    @Published var maxPlayerNumber = 0 { didSet { update() } }
    
    var eventLocation = "" { didSet{ update() } }
    var eventDescription = "" { didSet{ update() } }
    
    
    func update() {
        didChange.send(())
    }
}


struct createEventView: View {
    @ObservedObject var event = EventList()
    
    var body: some View {
        NavigationView {
            
            Form {
            // type event name
            
            // pick event type
                Picker(selection: $event.type, label: Text("Chose event type")) {
                    ForEach(0..<EventList.eventTypes.count) {
                        Text(EventList.eventTypes[$0]).tag($0)
                    }
                }
            // type min player number
                Stepper(value: $event.minPlayerNumber, in: 0...20) {
                    Text("Choose player minimum player number:  \(event.minPlayerNumber)")
                }
                
            // type max player number
                Stepper(value: $event.maxPlayerNumber, in: 0...20) {
                    Text("Choose max player number: \(event.maxPlayerNumber)")
                }
            
            // add event location
            // here will be creared button to open map and give possibility to mark event location
            // ? read adress based on annotation location, reverse option to add adress and based on adress add annotation
            
            // add event description
            // field so small... to change somehowe field size to be multiline and larger
                TextField("Add description",text: $event.eventDescription)
            }
            .navigationBarTitle("Add new event")
        }
    }
}

struct createEvent: View {
    var body: some View {
        createEventView()
        .tabItem {
            Text("createView")
            Image(systemName: "tv.fill")
        }
    }
}



class LoginData {
    var userName = ""
    var password = ""
}

struct loginButton: View {
    var body: some View {
        Text("LOGIN")
            .font(.headline)
            .foregroundColor(Color.white)
            .padding()
            .frame(width: 100, height: 50)
            .background(Color.green)
            .cornerRadius(5)
        
    }
}

struct loginView: View {
    @State var userName = ""
    @State var password = ""
    
    var body: some View {
        VStack {
            TextField("userName", text: $userName)
            SecureField("password", text: $password)
            
            Button(action: { print("login button tapped") }) {
                loginButton()
            }
        }

    }
}













