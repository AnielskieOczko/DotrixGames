//
//  EventObject.swift
//  DotrixGames
//
//  Created by Rafal on 17/02/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import SwiftUI
import MapKit


struct Event: Identifiable {
    var id: Int
    
    var name: String?
    var type: String?
    var mapCoordinates: CLLocationCoordinate2D?
    var numberOfPlayers: Int?
    var description: String?
    var gameName: String?
    var organizators: String?
}
