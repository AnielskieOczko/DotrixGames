//
//  EventObject.swift
//  DotrixGames
//
//  Created by Rafal on 17/02/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import SwiftUI
import MapKit
import Parse


struct Event: Identifiable {
    var id: String?
    
    var name: String?
    var type: String?
    var mapCoordinates: CLLocationCoordinate2D?
    var numberOfPlayers: String?
    var description: String?
    var gameName: String?
    var organizators: String?
    var date: Date?
    var participants: [PFUser]?
    var owner: PFUser?
    
    
}


