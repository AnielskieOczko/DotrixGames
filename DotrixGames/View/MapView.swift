//
//  MapView.swift
//  DotrixGames
//
//  Created by Rafal on 29/11/2020.
//  Copyright © 2020 RafalDX. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit


struct MapDisplayView: View {
    @State private var locations = [MKPointAnnotation]()
    @State private var newPinCoordinate = CLLocationCoordinate2D()
    
    var body: some View {
        ZStack {
            
            mapView(annotations: locations, newPinCoordinate: $newPinCoordinate)
                .edgesIgnoringSafeArea(.all)
                    VStack {
                Spacer()
                HStack {
                    Spacer()
                    // button to add new annotation on map
                    // this button will be replaced
                    // long tap gesture will trigger adding new annotation to map
                    Button(action: {
                        let newLocation = MKPointAnnotation()
                        // to add possibility to custom title, subtitle and others by user
                        newLocation.title = "Miasto Dotrixa"
                        newLocation.subtitle = "miasto"
                        newLocation.coordinate = self.newPinCoordinate
                        self.locations.append(newLocation)
                    }) {
                        Image(systemName: "plus")
                        }
                        .padding()
                        .background(Color.black.opacity(0.75))
                        .foregroundColor(Color.white)
                        .font(Font.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
            }
        }
        .tabItem {
            Text("Map")
            Image(systemName:"map.fill")
        }
    }
}

struct addLocationButton: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(Color.white)
                    .font(Font.title)
                    .clipShape(Circle())
                    .padding(.trailing)
            }
        }
    }
}
