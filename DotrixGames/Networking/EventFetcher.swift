//
//  EventFetcher.swift
//  DotrixGames
//
//  Created by Remigiusz Herba on 23/02/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import Foundation
import Parse


private class EventFactory {
    class func createEvent(from object: PFObject) -> Event {
        return Event(           id: object.objectId!,
                                name: object["name"] as! String,
                                type: object["type"] as! String,
                                mapCoordinates: CLLocationCoordinate2DMake(0, 0),
                                numberOfPlayers: "1",
                                description: "",
                                gameName: "",
                                organizators: "",
                                owner: object["owner"] as? String ?? "",
                                ownerId: object["ownerId"] as? String ?? "" )
    }
}

class EventFetcher {
    
    //qNGCFe8ata
    func getEvent(with id: String = "qNGCFe8ata", completionBlock: @escaping (Event?) -> Void) {
        let query = PFQuery(className:"Event")

        query.getObjectInBackground(withId: id) { (parseObject, error) -> Void in
            if error == nil, let parseObject = parseObject {
                completionBlock(EventFactory.createEvent(from: parseObject))
            } else {
                completionBlock(nil)
            }
        }
    }
    

    
    func deleteEvent(with id: String = "o2ra6iuW7G") {
        let query = PFQuery(className: "Event")
        
        query.getObjectInBackground(withId: id) {(parseObject, error) -> Void in
            if error == nil, let parseObject = parseObject {
                parseObject.deleteInBackground()
                print("RJ: Event with ID \(id) removed!")
            }
        }
    }
    
    func editEvent(with id: String = "") {
        let query = PFQuery(className: "Event")
        query.getObjectInBackground(withId: id) {(parseObject, error) -> Void in
            if error == nil, let parseObject = parseObject {
                parseObject["name"] = ""
                parseObject.saveInBackground()
            }
        }
    }
    
    func addEvent(from event: Event) {
        let query = PFObject(className:"Event")
        query["name"] = event.name!
        query["type"] = event.type!
        query["owner"] = event.owner
        query["ownerId"] = event.ownerId
        
        query.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
            print("RJ: event added")
          } else {
            // There was a problem, check error.description
            print("RJ: ", error!)
          }
        }
    }
    
    
    func getAllEventsFilterByName(with name: String, completionBlock: @escaping ([Event?]) -> Void) {
        let query = PFQuery(className: "Event")
        query.whereKey("name", hasPrefix: name)
        
        query.findObjectsInBackground { (events, error) in
            if error == nil {
                // no error
                var myEvents: [Event?] = []
                if let returnedEvents = events {
                    for event in returnedEvents {
                        myEvents.append(EventFactory.createEvent(from: event))
                    }
                    completionBlock(myEvents)
                }
                else {
                    completionBlock(myEvents) // probably it is not correct...
                }
            }
        }
    }
    
    func getAllEvents2(completionBlock: @escaping ([Event?]) -> Void) {
        let query = PFQuery(className: "Event")
        query.findObjectsInBackground { (events, error) in
            if error == nil {
                // no errors
                var myEvents: [Event?] = []
                if let returnedEvents = events {
                    print(returnedEvents.count)
                    for event in returnedEvents {
                        myEvents.append(EventFactory.createEvent(from: event))
                        print(event["name"] as! String)
                        //print(event.objectId!)
                    }
                    completionBlock(myEvents)
                }
                else {
                    completionBlock(myEvents) // ??
                }
            }
        }
    }
    

}





