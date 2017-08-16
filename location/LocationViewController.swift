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

class LocationViewController: UIViewController , CLLocationManagerDelegate {
    
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
        
        }
        
        locValue = locationManager.location!.coordinate
        
        print("locations = \(locValue?.latitude) \(locValue?.longitude)")
        
        let camera = GMSCameraPosition.camera(withLatitude: (locValue?.latitude)!, longitude: (locValue?.longitude)!, zoom: 18)
        
         mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view = mapView
        
        let currentlocation = CLLocationCoordinate2DMake((locValue?.latitude)!, (locValue?.longitude)!)
        let marker = GMSMarker(position: currentlocation)
        
        marker.title = "sumit"
        marker.map = mapView
        
       let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("handleLongPress:"))
      mapView?.addGestureRecognizer(longPressRecognizer)
    
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print(" here locations = \(locValue.latitude) \(locValue.longitude)")
    }

    func handleLongPress(recognizer: UILongPressGestureRecognizer)
    {
        if (recognizer.state == UIGestureRecognizerState.began)
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

}
