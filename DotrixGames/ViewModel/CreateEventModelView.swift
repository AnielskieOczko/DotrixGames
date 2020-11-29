//
//  CreateEventModelView.swift
//  
//
//  Created by Rafal on 29/11/2020.
//

import Foundation
import Combine

// describes event object
class EventList: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    var eventName = "" { didSet{ update() } }
    static let eventTypes = ["casual","tournament"]
    var type = 0 { didSet{ update() } }
    
    @Published var minPlayerNumber = 0 { didSet{ update() } }
    @Published var maxPlayerNumber = 0 { didSet { update() } }
    
    var eventLocation = "" { didSet{ update() } }
    var eventDescription = "" { didSet{ update() } }
    
    
    func update() {
        didChange.send(())
    }
}
