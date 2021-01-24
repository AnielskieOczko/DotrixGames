//
//  CreateEventModelView.swift
//  
//
//  Created by Rafal on 29/11/2020.
//

import Foundation
import Combine
import MapKit
// describes event object
class Event: ObservableObject {

    var didChange = PassthroughSubject<Void, Never>()
    
    var name = "" { didSet{ update() } }
    static let types = ["casual","tournament"]
    var type = 0 { didSet{ update() } }
    var mapCoordinates: CLLocationCoordinate2D?  = nil { didSet { update() } }
    @Published var numberOfPlayers = 0 { didSet{ update() } }
    var description = "" { didSet{ update() } }
    var gameName = "" { didSet{ update() } }
    var organizators = "" { didSet{ update() } }
    
    func update() {
        didChange.send(())
    }
}


