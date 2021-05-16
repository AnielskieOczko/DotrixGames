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

    var loginManager: AuthorizaionManager = AuthorizaionManager.shared
    
    @Published var model: [Event] = []
    @Published var myEvents: [Event] = []
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
                //print("RJ say: \(e!)")
            }
        }
        
        // get all events created by current user
        let userID: String = self.loginManager.currentUser?.userId ?? "niezalogowany"
        fetcher.getAllEventsFilteredEventOwnerID(with: userID) { [weak self] (events) in
            for e in events {
                self?.myEvents.append(e!)
                //print("RJ say: \(e!)")
            }
        }
    }
    
    
    // MARK: Intent(s)
    func addNewEvent(event: Event) {
        
        fetcher.addEvent(from: event) { [weak self] (eventId) in
            guard let eventId = eventId else {
                return
            }
            var event = event
            event.changeId(id: eventId)
            print(self!.loginManager.currentUser?.userId ?? "niezalogowany")
            let userID: String? = self?.loginManager.currentUser?.userId
            self?.model.append(event)
            if (event.ownerId == userID) {
                self?.myEvents.append(event)
            }
        }
    }
    
    func editEvent(event: Event, name: String?, type: String?, numberOfPlayers: String?, description: String?, gameName: String?, organizators: String?) {
        
        // update event item on server
        fetcher.editEvent(event: event,
                          name: name!,
                          type: type!,
                          numberOfPlayers: numberOfPlayers!,
                          description: description!,
                          gameName: gameName!,
                          organizators: organizators!)
        
        // update event item localy (avoid fetching data)
        // TODO: bad approach but how to get list itemn index from view to send it here
        var index: Int = 0
        for e in self.myEvents {
            if e.id == event.id! {
                self.myEvents[index].name = name!
                self.myEvents[index].type = type!
                self.myEvents[index].numberOfPlayers = numberOfPlayers!
                self.myEvents[index].description = description!
                self.myEvents[index].gameName = gameName!
                self.myEvents[index].organizators = organizators!
            }
            index += 1
        }
    }
    
    func deleteEvent(id: String) {

        fetcher.deleteEvent(with: id)
        print(self.myEvents.count)
        
        // TODO: bad approach but how to get list itemn index from view to send it here
        var index: Int = 0
        for e in self.myEvents {
            if e.id == id {
                self.myEvents.remove(at: index)
            }
            index += 1
        }
        
        index = 0
        for e in self.model {
            if e.id == id {
                self.model.remove(at: index)
            }
            index += 1
        }
    }
    
    
    func converDateToString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let eventDateAsString: String = dateFormatter.string(from: date)
        
        return eventDateAsString
    }
    

}


