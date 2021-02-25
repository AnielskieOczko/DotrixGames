//
//  ModelViewAddNewEvent.swift
//  DotrixGames
//
//  Created by Rafal on 18/02/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//


import SwiftUI

class AddNewEventModelView: ObservableObject {
    
    @Published private var model: AddNewEventModel = AddNewEventModel()
    
    var eventTypes: [String] {
        return model.getEventTypes()
    }
    
}
