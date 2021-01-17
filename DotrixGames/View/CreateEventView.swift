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


struct createEventView: View {
    @ObservedObject var event = EventList()
    @State var showMap = false
    @State private var newPinCoordinate = CLLocationCoordinate2D()
    
    @ObservedObject  var viewModel = EventViewModel()
    
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
                
                Button(action: { self.event.eventCoordinates = self.newPinCoordinate } ) {
                    Text("Add location")
                    
                }
                
                VStack {
                    NavigationLink(destination: MapDisplayView(), isActive: $showMap) {
                        EmptyView()
                    }
                }

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
