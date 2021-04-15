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
//    @State var name: String = ""
//    @State var type: String = ""
//    @State var numberOfPlayers: String = ""
//    @State var description = ""
//    @State var gameName = ""
//    @State var organizators = ""
    func editEvent(event: Event) {
        let query = PFQuery(className: "Event")
        query.getObjectInBackground(withId: event.id!) {(parseObject, error) -> Void in
            if error == nil, let parseObject = parseObject {
                parseObject["name"] = event.name!
                parseObject["type"] = event.type!
                parseObject["numberOfPlayers"] = event.numberOfPlayers
                parseObject["description"] = event.description
                parseObject["gameName"] = event.gameName
                parseObject["organizators"] = event.organizators
                parseObject.saveInBackground()
                parseObject.fetchInBackground()
                print("RJ say: event updated")
            }
        }
    }
    
    func addEvent(from event: Event) {
        let query = PFObject(className:"Event")
        
        query["name"] = event.name!
        query["type"] = event.type!
        //query["mapCoordinates"] = CLLocationCoordinate2DMake(0, 0) // to change for now no possibility to add coordinates. CL CORD must be converted to PFGEOPOINT
        query["numberOfPlayers"] = event.numberOfPlayers!
        query["description"] = event.description!
        query["gameName"] = event.gameName!
        query["organizators"] = event.organizators!
        query["date"] = Date()
        //query["participants"] = event.participants!
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
    
    

    
    func getAllEventsFilteredEventOwnerID(with ownerID: String, completionBlock: @escaping ([Event?]) -> Void) {
        let query = PFQuery(className: "Event")
        query.whereKey("ownerId", hasPrefix: ownerID)
        
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





