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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return Event(           id: object.objectId!,
                                name: object["name"] as? String ?? "",
                                type: object["type"] as? String ?? "",
                                mapCoordinates: CLLocationCoordinate2DMake(0, 0),
                                numberOfPlayers: object["numberOfPlayers"] as? String ?? "",
                                description: object["description"] as? String ?? "",
                                gameName: object["gameName"] as? String ?? "",
                                organizators: object["organizators"] as? String ?? "",
                                startDate: object["startDate"] as? Date ?? Date(),
                                endDate: object["endDate"] as? Date ?? Date(),
                                creationDate: object["creationDate"] as? Date ?? Date(),
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
    

    
    func deleteEvent(with id: String) {
        let query = PFQuery(className: "Event")
        
        query.getObjectInBackground(withId: id) {(parseObject, error) -> Void in
            if error == nil, let parseObject = parseObject {
                
                parseObject.deleteInBackground { (isRemoved, error) in
                    if isRemoved {
                        print("RJ: Event with ID \(id) removed!")
                        
                    } else {
                        print("RJ: \(error.debugDescription)")
                    }
                }
            } else {
                print("RJ: \(error.debugDescription)")
            }
        }
    }

    func editEvent(event: Event, name: String?, type: String?, numberOfPlayers: String?, description: String?, gameName: String?, organizators: String?) {
        let query = PFQuery(className: "Event")
        query.getObjectInBackground(withId: event.id!) {(parseObject, error) -> Void in
            if error == nil, let parseObject = parseObject {
                
                print("description: \(description!)")
                
                parseObject["name"] = name!
                parseObject["type"] = type!
                parseObject["numberOfPlayers"] = numberOfPlayers!
                parseObject["description"] = description!
                parseObject["gameName"] = gameName!
                parseObject["organizators"] = organizators!
                
                parseObject.saveInBackground { (isSaved, error) in
                    if error == nil {
                        print("RJ say: event saved: \(parseObject.allKeys)")
                        print("RJ say: event saved: \(parseObject)")
                    } else {
                        print("Issue with saving event during editing: \(error.debugDescription)")
                    }
                }
                print("RJ say: event updated")
            } else {
                print("Issue during event edit: \(error.debugDescription)")
            }
        }
    }
    
    func addEvent(from event: Event, completionBlock: ((String?) -> ())? = nil) {
        let query = PFObject(className:"Event")
        
        query["name"] = event.name!
        query["type"] = event.type!
        //query["mapCoordinates"] = CLLocationCoordinate2DMake(0, 0) // to change for now no possibility to add coordinates. CL CORD must be converted to PFGEOPOINT
        query["numberOfPlayers"] = event.numberOfPlayers!
        query["description"] = event.description!
        query["gameName"] = event.gameName!
        query["organizators"] = event.organizators!
        query["startDate"] = event.startDate
        query["endDate"] = event.endDate
        query["creationDate"] = event.creationDate
        //query["participants"] = event.participants!
        query["owner"] = event.owner
        query["ownerId"] = event.ownerId
        
        query.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
            completionBlock?(query.objectId)
            print("RJ: event added")
            print(query)
            print(query.allKeys)
            
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
                        print(event)
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





