//
//  EditEvent.swift
//  DotrixGames
//
//  Created by Rafal on 14/04/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import SwiftUI
import MapKit
import Parse

struct EditEvent: View {
    
    @Environment(\.presentationMode) var presentation
    
    
    @State var event: Event
    @State var viewModel: EventListViewModel
    @State var name: String = ""
    @State var type: String = ""
    @State var numberOfPlayers: String = ""
    @State var description = ""
    @State var gameName = ""
    @State var organizators = ""
    //@State var date = ""
    @State  var participants: [PFUser] = []
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Group {
                    Text("Name: ")
                    TextField("new value", text: $name)

                    Text("type: ")
                    TextField("new value", text: $type)
                }

                Text("Number of players: ")
                TextField("new value", text: $numberOfPlayers)
                
                Text("Description: ")
                TextField("new value", text: $description)

                Text("GameName: ")
                TextField("new value", text: $gameName)

                Text("Organizators")
                TextField("new value", text: $organizators)


            }
            .padding()
            
            HStack(alignment: .center, spacing: 40.0) {
                Button(action: {
                    // update event values
                    
                    print("clicked done")
                    viewModel.editEvent(event: event)
                    presentation.wrappedValue.dismiss()
                }) {
                    Text("Done")
                }
                Button(action: {
                    // close view without saving
                    presentation.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
            }
        }


    }
}

struct EditEvent_Previews: PreviewProvider {

    static var previews: some View {
        EditEvent(event: Event(id: "xxx", name: "test", type: "test", mapCoordinates: CLLocationCoordinate2D(), numberOfPlayers: "1", description: "test", gameName: "test", organizators: "test", date: Date(), participants: [PFUser()], owner: "testOwner", ownerId: "123"), viewModel: EventListViewModel())
    }
}
