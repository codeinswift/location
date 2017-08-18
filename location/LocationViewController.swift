 //
//  LocationViewController.swift
//  location
//
//  Created by Sumit Bansal on 16/08/17.
//  Copyright © 2017 Sumit. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import CoreLocation

class LocationViewController: UIViewController , CLLocationManagerDelegate,UIGestureRecognizerDelegate {
    
    let locationManager = CLLocationManager()

    var locValue:CLLocationCoordinate2D?
    var mapView : GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GMSServices.provideAPIKey("AIzaSyAxESpX-APxZFx_EyHbV3-OYLunqn9wr8U")
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        print("vh")
        }
        
        locValue = locationManager.location?.coordinate
        
        print("locations = \(locValue?.latitude) \(locValue?.longitude)")
        
        let camera = GMSCameraPosition.camera(withLatitude: (locValue?.latitude)!, longitude: (locValue?.longitude)!, zoom: 18)
        
         mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view = mapView
        
        let currentlocation = CLLocationCoordinate2DMake((locValue?.latitude)!, (locValue?.longitude)!)
        let marker = GMSMarker(position: currentlocation)
        
        marker.title = "sumit"
        marker.map = mapView
        
//       let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("handleLongPress:"))
//      self.mapView?.addGestureRecognizer(longPressRecognizer)
    
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
        longPressGesture.delegate = self
        longPressGesture.minimumPressDuration = 1
        self.mapView?.addGestureRecognizer(longPressGesture)

        
        
    }
    
    // function which is triggered when handleTap is called
    func handleLongPress(_ sender: UILongPressGestureRecognizer) {
            print("dcefd")
//            let longPressPoint = recognizer.location(in: mapView);
//            let coordinate = mapView?.projection.coordinate(for: longPressPoint )
//            //Now you have Coordinate of map add marker on that location
//            let marker = GMSMarker(position: coordinate!)
//            marker.opacity = 0.6
//            //      marker.position = GMSCameraPosition.camera(withTarget: coordinate, zoom: 18)
//            marker.title = "Current Location"
//            marker.snippet = ""
//            marker.map = mapView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print(" here locations = \(locValue.latitude) \(locValue.longitude)")
    }

    func handleLongPress(recognizer: UITapGestureRecognizer)
    {
        if (recognizer.state == UIGestureRecognizerState.ended)
        {
            print("dcefd")
            let longPressPoint = recognizer.location(in: mapView);
            let coordinate = mapView?.projection.coordinate(for: longPressPoint )
            //Now you have Coordinate of map add marker on that location
            let marker = GMSMarker(position: coordinate!)
            marker.opacity = 0.6
      //      marker.position = GMSCameraPosition.camera(withTarget: coordinate, zoom: 18)
            marker.title = "Current Location"
            marker.snippet = ""
            marker.map = mapView
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer is UILongPressGestureRecognizer) {
            return true
        } else {
            return false
        }
    }

    
//    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
//        println("It works")
//    }

}
