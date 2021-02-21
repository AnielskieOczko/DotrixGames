//
//  ModelAddNewEventView.swift
//  DotrixGames
//
//  Created by Rafal on 18/02/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import Foundation


struct AddNewEventModel {
    
    var eventTypes: [String] = ["Casual","Tournament"]
    
    func getEventTypes() -> [String] {
        return eventTypes
    }
    
}
