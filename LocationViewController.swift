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
    
    var defaultMarker : GMSMarker?
    var newLocation = [maplocation]()
    let locationManager = CLLocationManager()

    var locValue:CLLocationCoordinate2D?
    var mapView : GMSMapView?
    
    var newLocationTitle : String?
    
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
        
        locValue = locationManager.location?.coordinate
        
    //    print("locations = \(locValue?.latitude) \(locValue?.longitude)")
        
   //     let camera = GMSCameraPosition.camera(withLatitude: (locValue!.latitude), longitude: (locValue!.longitude), zoom: 18)
     
             let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2DMake(19.017615,72.856164), zoom: 18)
     
         mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        view = mapView
        
      //  let currentlocation = CLLocationCoordinate2DMake((locValue?.latitude)!, (locValue?.longitude)!)
        
     let currentlocation =   CLLocationCoordinate2DMake(19.017615,72.856164)
         defaultMarker = GMSMarker(position: currentlocation)
        
        defaultMarker?.title = "sumit"
        defaultMarker?.map = mapView

        let pressGesture = UITapGestureRecognizer(target: self, action: #selector(self.handlePress(gestureReconizer:)))
        
        pressGesture.delegate = self
        
        self.mapView?.addGestureRecognizer(pressGesture)

        
        
    }
    
    // function which is triggered when handleTap is called
    func handlePress(gestureReconizer : UITapGestureRecognizer) {
            print("tap press")
        self.defaultMarker?.map = nil
        let longPressPoint = gestureReconizer.location(in: mapView)
        let coordinate = mapView?.projection.coordinate(for: longPressPoint )
        
        //Now you have Coordinate of map add marker on that location
        print(coordinate?.latitude ?? 19.017615, coordinate?.longitude ?? 72.856164)
        
        let marker = GMSMarker(position: coordinate!)
        marker.title = "Selected Location"
        marker.snippet = ""
        marker.map = mapView
        
        let refreshAlert = UIAlertController(title: "Save", message: "Want to save this location", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Ok here")
            
                    let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)
            
                    alert.addTextField { (textField) in
                        textField.text = "Some default text"
                    }
            
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:  { (action: UIAlertAction!) in
                        let textField = alert.textFields![0]
                        print("Text field: \(textField.text ?? "no title entered")")
                        self.newLocationTitle = textField.text
                        
                        self.newLocation.append(maplocation(title: self.newLocationTitle!, newLatitiude: coordinate?.latitude ?? 19.017615, newLongitutde: coordinate?.longitude ?? 72.856164))
                        
                        print(self.newLocation.last?.locationtitle ?? "u")
                        print(self.newLocation.last?.latitude ?? "u")
                        print(self.newLocation.last?.longitude ?? "u")
                        
                        _ = self.navigationController?.popViewController(animated: true)


                    }))
            
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                        print("User Cancel")
                    }))
            
                    self.present(alert, animated: true, completion: nil)
            
                    }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("User Cancel")
            marker.map = nil
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
           }

    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer is UITapGestureRecognizer)
        {
            return true
        }
        else {
                return false
             }
    }

}
