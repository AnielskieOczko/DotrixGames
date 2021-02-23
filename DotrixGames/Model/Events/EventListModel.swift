//
//  EventsModel.swift
//  DotrixGames
//
//  Created by Rafal on 17/01/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import Foundation
import MapKit

struct EventsList {
    
    var eventList: [Event]
    
    
    init(events: [Event]) {
        eventList = []
        
        for index in 0..<events.count {
            eventList.append(events[index])
        }
    }
    
    
    mutating func addEvent(newEvent: Event) {
        eventList.append(newEvent)
    }
    
    mutating func removeEvent(event: Event) {
        
        for index in 0..<eventList.count {
            if eventList[index].id == event.id {
                eventList.remove(at: index)
            }
        }
    }
    
    func editEvent() {
        // edit selected event
        
    }
    
    func getEventList() -> [Event] {
        return eventList
    }
    
    
    
//    func createNewEvent(id: Int,
//                        name: String,
//                        type: String,
//                        mapCoordinator: CLLocationCoordinate2D,
//                        numberOfPlayers: Int,
//                        desciption: String,
//                        gameName: String,
//                        organizators: String) -> Event {
//
//        Event(id: id,
//              name: name,
//              type: type,
//              mapCoordinates: mapCoordinator,
//              numberOfPlayers: numberOfPlayers,
//              description: desciption,
//              gameName: gameName,
//              organizators: organizators)
//    }
}



