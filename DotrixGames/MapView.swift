//
//  MapView.swift
//  DotrixGames
//
//  Created by Rafal on 23/11/2020.
//  Copyright © 2020 RafalDX. All rights reserved.
//

import SwiftUI
import MapKit

struct mapView: UIViewRepresentable {
    
    // list of annotations
    var annotations: [MKAnnotation]
    // store here new pin coordinates taken from long tap location on map
    @Binding var newPinCoordinate: CLLocationCoordinate2D
    
    // class created to control map
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: mapView
        
        init(_ parent: mapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
            //parent.centerCoordinator = mapView.centerCoordinate
        }
        // func get coordinates from place where long tap gesture detected and store coordinates in newPinCoordinator
        @objc func addAnnotationLongPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
            if gestureRecognizer.state == .ended {
                let selectedPoint = gestureRecognizer.location(in: gestureRecognizer.view)
                let newCoordinates = (gestureRecognizer.view as? MKMapView)?.convert(selectedPoint, toCoordinateFrom: gestureRecognizer.view)
                guard let _newCoordinates = newCoordinates else { return }
                let newAnnotation = MKPointAnnotation()
                newAnnotation.coordinate = _newCoordinates
                parent.annotations.append(newAnnotation)
                parent.newPinCoordinate = _newCoordinates
                print("longPress: \(_newCoordinates)")
                print(parent.annotations.count)
            }
        }
        
        func addAnnotations(view: MKMapView) {
            view.addAnnotations(parent.annotations)
        }
        // when this function uncommented adding annotations does not works
        /*
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
         */
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        // define long press gesture functionality and add it to the view
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.addAnnotationLongPress(_:)))
        mapView.addGestureRecognizer(longPress)
        
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        //view.delegate = context.coordinator
        // checks if annotation count in view is same line in model if not, remove all annotations and replace them by new annotations from model
        // this should be triggered everytime something changes in view
        //if annotations.count != view.annotations.count {
            print(annotations.count)
            //view.removeAnnotations(view.annotations)
            view.addAnnotations(annotations)
        //}
    }
}
