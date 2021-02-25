//
//  ViewAddNewEvent.swift
//  DotrixGames
//
//  Created by Rafal on 25/02/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import Foundation
import SwiftUI

struct AddNewEventView: View {
    
    
    @State var viewModel: EventListViewModel
    @State var name: String = ""
    @State var type: String = ""
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $name)
                TextField("Type", text: $type)
            }
            
            Button(action: {
                viewModel.addNewEvent(event: Event(id: 1, name: name, type: type))
            }, label: {
                Text("Submit")
            })
        }
    }
    
}




struct DisplayAddNewEventView2_Previews: PreviewProvider {
    static var previews: some View {
        AddNewEventView(viewModel: EventListViewModel())
    }
}
