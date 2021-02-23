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
        return Event(id: 1,
                                name: object["name"] as! String,
                                type: object["type"] as! String,
                                mapCoordinates: CLLocationCoordinate2DMake(0, 0),
                                numberOfPlayers: 1,
                                description: "",
                                gameName: "",
                                organizators: "")
    }
}

class EventFetcher {
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
}
