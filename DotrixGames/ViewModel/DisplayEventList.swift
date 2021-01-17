//
//  DisplayEventList.swift
//  DotrixGames
//
//  Created by Rafal on 17/01/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import SwiftUI
import MapKit

struct DisplayEventList: View {
    
    @ObservedObject var viewModel = EventViewModel()
    
    
    
    var body: some View {

        NavigationView {
            List(self.viewModel.events) {event in
                HStack {
                    Text(event.name)
                    Text(event.description)
                    Text(event.type)
                }
            }
            .navigationBarTitle(Text("Event List"))
            .navigationBarItems(trailing: Button(action: {
                // create and add new event to the list
                self.viewModel.addNewEvent(event: self.viewModel.createNewEvent(id: 3, name: "new event3", type: "Casual", mapCoordinator: CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00), numberOfPlayers: 1, desciption: "description3", gameName: "Dota", organizators: "Dotrix"))
            }, label: { Text("Add event") }))
        }
    }
}



