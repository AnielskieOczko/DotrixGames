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
                    HStack {
                        Text("Name: ")
                        TextField("\(event.name!)", text: $name)
                    }
                    HStack {
                        Text("type: ")
                        TextField("\(event.type!)", text: $type)
                    }
                }
                HStack {
                    Text("Number of players: ")
                    TextField("\(event.numberOfPlayers!)", text: $numberOfPlayers)
                }

                HStack {
                    Text("Description: ")
                    TextField("\(event.description!)", text: $description)
                }

                HStack {
                    Text("GameName: ")
                    TextField("\(event.gameName!)", text: $gameName)
                }

                HStack {
                    Text("Organizators")
                    TextField("\(event.organizators!)", text: $organizators)
                }
            }
            .padding()
            
            HStack(alignment: .center, spacing: 40.0) {
                Button(action: {
                    // update event values
                    
                    print("clicked done")
                    viewModel.editEvent(event: event, name: name, type: type, numberOfPlayers: numberOfPlayers, description: description, gameName: gameName, organizators: organizators)
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
        EditEvent(event: Event(id: "xxx", name: "test", type: "test", mapCoordinates: CLLocationCoordinate2D(), numberOfPlayers: "1", description: "test", gameName: "test", organizators: "test",startDate: Date(), endDate: Date(), creationDate: Date(), participants: [PFUser()], owner: "testOwner", ownerId: "123"), viewModel: EventListViewModel())
    }
}
