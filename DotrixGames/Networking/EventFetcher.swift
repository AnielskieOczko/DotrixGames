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
                                organizators: "")
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
    
    
    func addEvent(from event: Event) {
        let query = PFObject(className:"Event")
        query["name"] = event.name!
        query["type"] = event.type!
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
    
    
    func getAllEvents() {
        let query = PFQuery(className: "Event")
        query.findObjectsInBackground { (events, error) in
            if error == nil {
                // no errors
                if let returnedEvents = events {
                    print(returnedEvents.count)
                    for event in returnedEvents {
                        print(event["name"] as! String)
                    }
                }
            }
        }
    }
    

}





