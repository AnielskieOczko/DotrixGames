//
//  MyEventsViewModel.swift
//  DotrixGames
//
//  Created by Rafal on 05/04/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

class MyOwnEventListViewModel: ObservableObject {

    @Published var model: [Event] = []
    //@Published var model: EventsList = EventsList()
    let fetcher = EventFetcher()
    
    
    init(name: String) {
        fetcher.getAllEventsFilterByName(with: name) { [weak self] events in
            for e in events {
                self?.model.append(e!)
                print("RJ say: \(e!)")
            }
        }
    }
    
    
}
