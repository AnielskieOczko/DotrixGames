//
//  EventsNavigationController.swift
//  DotrixGames
//
//  Created by Rafal on 09/05/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import Foundation
import Combine

class EventNavigationController: ObservableObject {

    @Published var EventViewIsShown: Bool = false
    @Published var EventEditViewIsShown: Bool = false
    
}
