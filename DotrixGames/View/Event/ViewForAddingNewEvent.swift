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


struct ViewForAddingNewEvent: View {
    
    @State var showMap = false
    @State private var newPinCoordinate = CLLocationCoordinate2D()
    @State var locations = [MKPointAnnotation]()
    @State var viewModel: AddNewEventModelView
    
    var eventTypes: [String] = ["Tournament", "Casual"]
    @State var name: String = ""
    @State var type: String = ""
    @State var playerNumber: Int = 0
    @State var description: String = ""
    @State var gameName: String = ""
    @State var eventOwner: String = ""
    
    var body: some View {
        NavigationView {
            
            VStack {
                Form {
                // type event name
                    TextField("Name", text: $name)
                // pick event type
                    Picker(selection: $name, label: Text("Chose event type")) {
                        ForEach(0..<viewModel.eventTypes.count) {
                            Text(self.viewModel.eventTypes[$0]).tag($0)
                        }
                    }
                // type min player number
                    Stepper(value: $playerNumber, in: 0...20) {
                        Text("Number of players  \(playerNumber)")
                    }
                    
                // add event location
                // here will be creared button to open map and give possibility to mark event location
                // ? read adress based on annotation location, reverse option to add adress and based on adress add annotation
                
                // add event description
                // field so small... to change somehowe field size to be multiline and larger
                    TextField("Add description",text: $description)
                    TextField("Game name",text: $gameName)
                    TextField("Event owner", text: $eventOwner)

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
                    Button(action: {
                        // here function to add new event to the list
                    }, label: {
                        Text("Submit")
                    })
                }
                .padding()

            }
        }
    }
}




struct createEvent: View {

    @State var viewModel: EventListViewModel
    var body: some View {
        DisplayEventList(viewModel: viewModel)
        .tabItem {
            Text("Add event")
            Image(systemName: "tv.fill")
        }
    }
}


struct DisplayAddNewEventView_Previews: PreviewProvider {
    static var previews: some View {
        ViewForAddingNewEvent(viewModel: AddNewEventModelView())
    }
}
