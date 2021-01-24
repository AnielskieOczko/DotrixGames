//
//  DisplayEventList.swift
//  DotrixGames
//
//  Created by Rafal on 17/01/2021.
//  Copyright © 2021 RafalDX. All rights reserved.
//

import SwiftUI
import MapKit

struct DisplayEventList: View {
    
    @State var viewModel: EventViewModel
    
    
    var body: some View {

        NavigationView {
            List(self.viewModel.events) {event in
                HStack {
                    Text(event.name)
                    Text(event.description)
                    Text(event.type)
                }
            }
            .navigationBarTitle(Text("Event List"))
            }
        }
    }



