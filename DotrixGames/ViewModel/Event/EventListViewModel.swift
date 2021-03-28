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

    @Published var model: [Event] = []
    //@Published var model: EventsList = EventsList()
    let fetcher = EventFetcher()
    
    
    init() {
//        fetcher.getEvent { [weak self] (event) in
//            self?.model.append(event!)
//            //self?.model.eventList.append(event!)
//        }
        fetcher.getAllEvents2 { [weak self] (events) in
            for e in events {
                self?.model.append(e!)
                print("RJ say: \(e!)")
            }
        }
        // fetcher.getAllEvents()
    }
    
    
//    func getMyEvents() -> [Event] {
//        
//        let filteredEvents: [Event] = []
//        ForEach (model.filter({ "\($0)".contains("RJ")) }) { event in
//            
//        }
//        return filteredEvents
//    }
    
    
    
//    func fetchEventList() {
//
//        let testEvent1 = Event(id: 1,
//                                          name: "test name1",
//                                          type: "Casaul",
//                                          mapCoordinates: CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),
//                                          numberOfPlayers: 1,
//                                          description: "test description1",
//                                          gameName: "Szachy",
//                                          organizators: "test organizer1")
//        let testEvent2 = Event(id: 2,
//                                          name: "test name2",
//                                          type: "Tournament",
//                                          mapCoordinates: CLLocationCoordinate2D(latitude: 0.00, longitude: 0.00),
//                                          numberOfPlayers: 1,
//                                          description: "test description2",
//                                          gameName: "Szachy",
//                                          organizators: "test organizer2")
//
//
//
//        fetcher.getEvent { [weak self] (event) in
//            self?.model.eventList.append(event!)
//        }
//
//    }
    
//    // MARK: Access to the model
//    var events: [Event] {
////        model.getEventList()
//    }
//
    // MARK: Intent(s)
    func addNewEvent(event: Event) {
        model.append(event)
        fetcher.addEvent(from: event)
//        model.addEvent(newEvent: event)
        
    }
    
    func removeEvent(event: Event) {
//        model.removeEvent(event: event)
    }
    
    func editEvent(event: Event) {
//        model.editEvent()
    }
}


