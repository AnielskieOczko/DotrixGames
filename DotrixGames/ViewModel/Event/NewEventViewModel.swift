//
//  NewEventViewModel.swift
//  DotrixGames
//
//  Created by Rafal on 17/01/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

class EventListViewModel: ObservableObject {

    @Published private var model: EventsList = EventListViewModel.createEventList()
    
    static func createEventList() -> EventsList {
        
        let testEvent1 = Event(id: 1,
                                          name: "test name1",
                                          type: "Casaul",
                                          mapCoordinates: CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),
                                          numberOfPlayers: 1,
                                          description: "test description1",
                                          gameName: "Szachy",
                                          organizators: "test organizer1")
        let testEvent2 = Event(id: 2,
                                          name: "test name2",
                                          type: "Tournament",
                                          mapCoordinates: CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),
                                          numberOfPlayers: 1,
                                          description: "test description2",
                                          gameName: "Szachy",
                                          organizators: "test organizer2")
        
        var events = [Event]()
        events.append(testEvent1)
        events.append(testEvent2)
        
        
        return EventsList(events: events)
    }
    
    // MARK: Access to the model
    var events: [Event] {
        model.getEventList()
    }
    
    // MARK: Intent(s)
    func addNewEvent(event: Event) {
        model.addEvent(newEvent: event)
    }
    
    func removeEvent(event: Event) {
        model.removeEvent(event: event)
    }
    
    func editEvent(event: Event) {
        model.editEvent()
    }
    
//    func createNewEvent(id: Int,
//                        name: String,
//                        type: String,
//                        mapCoordinator: CLLocationCoordinate2D,
//                        numberOfPlayers: Int,
//                        desciption: String,
//                        gameName: String,
//                        organizators: String) -> Event {
//        print(events.count)
//        return model.createNewEvent(id: id, name: name, type: type, mapCoordinator: mapCoordinator, numberOfPlayers: numberOfPlayers, desciption: desciption, gameName: gameName, organizators: organizators)
//    }
    
}


