//
//  ViewAddNewEvent.swift
//  DotrixGames
//
//  Created by Rafal on 25/02/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import Foundation
import SwiftUI
import Parse

struct AddNewEventView: View {
    
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var loginManager: AuthorizaionManager
    
    @State var viewModel: EventListViewModel
    @State var name: String = ""
    @State var type: String = ""
    @State var numberOfPlayers: String = ""
    @State var description: String = ""
    @State var gameName = ""
    @State var organizators = ""
    //@State var date = ""
    @State  var participants: [PFUser] = []
    @State var eventStartDate: Date = Date()
    @State var eventEndDate: Date = Date()
    
    var body: some View { 
        VStack {
            Text("\(loginManager.currentUser?.login ?? "niezalogowany")")
            Text("\(loginManager.currentUser?.userId ?? "niezalogowany")")
            Form {
                TextField("Name", text: $name)
                TextField("Type", text: $type)
                // TODO: coordinates from map
                TextField("Number of players", text: $numberOfPlayers)
//                TextField("Description", text: $description)
                MultiLineTF(txt: "Description...", editeEnabled: true, returnTxt: $description)
                    .frame(maxWidth: .infinity, minHeight:   100, maxHeight: .infinity)
                TextField("gameName", text: $gameName)
                TextField("organizators", text: $organizators)
                //TODO: add date picker
                EventDatePickerView(eventStartDate: $eventStartDate, eventEndDate: $eventEndDate)
                
            }
            
            Button(action: {
                viewModel.addNewEvent(event: Event(name: name, type: type, numberOfPlayers: numberOfPlayers, description: description, gameName: gameName, organizators: organizators, startDate: eventStartDate, endDate: eventEndDate, creationDate: Date(), participants: participants, owner: loginManager.currentUser?.login ?? "niezalogowany", ownerId: loginManager.currentUser?.userId ?? "niezalogowany"))
                presentation.wrappedValue.dismiss()
            }, label: {
                Text("Submit")
            })
        }
    }
    
}




struct DisplayAddNewEventView2_Previews: PreviewProvider {
    static var previews: some View {
        AddNewEventView(viewModel: EventListViewModel(), description: "description")
    }
}
