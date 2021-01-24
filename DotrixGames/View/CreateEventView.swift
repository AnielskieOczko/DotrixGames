//
//  CreateEventView.swift
//  DotrixGames
//
//  Created by Rafal on 29/11/2020.
//  Copyright © 2020 RafalDX. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit


struct CreateEventView: View {
    @ObservedObject var event = Event()
    @State var showMap = false
    @State private var newPinCoordinate = CLLocationCoordinate2D()
    @State var locations = [MKPointAnnotation]()
    
    @State var viewModel: EventViewModel
    
    
    var body: some View {
        NavigationView {
            
            VStack {
                Form {
                // type event name
                    TextField("Name", text: $event.name)
                // pick event type
                    Picker(selection: $event.type, label: Text("Chose event type")) {
                        ForEach(0..<Event.types.count) {
                            Text(Event.types[$0]).tag($0)
                        }
                    }
                // type min player number
                    Stepper(value: $event.numberOfPlayers, in: 0...20) {
                        Text("Number of players  \(event.numberOfPlayers)")
                    }
                    
                // add event location
                // here will be creared button to open map and give possibility to mark event location
                // ? read adress based on annotation location, reverse option to add adress and based on adress add annotation
                
                // add event description
                // field so small... to change somehowe field size to be multiline and larger
                    TextField("Add description",text: $event.description)
                    TextField("Game name",text: $event.gameName)
                    TextField("Event owner", text: $event.organizators)

                    VStack {
                        HStack{
                            NavigationLink(destination: mapView(annotations: locations, newPinCoordinate: $newPinCoordinate), isActive: $showMap) {
                                Button(action: { self.showMap = true } ) {
                                    Text("Open map")
                                }
                            }

                            Text("latitude: \(self.newPinCoordinate.latitude), latitude: \(self.newPinCoordinate.longitude)")
                        }
                    }
                    .navigationBarTitle("Map")
                }
                .navigationBarTitle("Add new event")
                
                VStack {
                    Button(action: { self.viewModel.addNewEvent(event: self.viewModel.createNewEvent(id: 3, name: self.event.name, type: Event.types[self.event.type], mapCoordinator: self.newPinCoordinate, numberOfPlayers: self.event.numberOfPlayers, desciption: self.event.description, gameName: self.event.gameName, organizators: self.event.organizators))  }, label: {
                        Text("Submit")
                    })
                }
                .padding()

            }
        }
    }
}




struct createEvent: View {

    @State var viewModel: EventViewModel
    var body: some View {
        CreateEventView(viewModel: viewModel)
        .tabItem {
            Text("Add event")
            Image(systemName: "tv.fill")
        }
    }
}
