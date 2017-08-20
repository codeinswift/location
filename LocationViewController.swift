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
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    
    var lat : Double? = 19.017615
    var lon : Double? = 72.856164
    var tit : String? = "hbj"
    
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
        
    //  default camera setting and currentlocation by simulator
    //  let camera = GMSCameraPosition.camera(withLatitude: (locValue!.latitude), longitude: (locValue!.longitude), zoom: 18)
    //  let currentlocation = CLLocationCoordinate2DMake((locValue?.latitude)!, (locValue?.longitude)!)
    //hard-coded default location
        
        
    let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2DMake(19.017615,72.856164), zoom: 18)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
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
        
        
    //  Now we have Coordinate of map add marker on that location
        print(coordinate?.latitude ?? 19.017615, coordinate?.longitude ?? 72.856164)
        defaultMarker = GMSMarker(position: coordinate!)
        defaultMarker?.title = "Selected Location"
        defaultMarker?.snippet = ""
        defaultMarker?.map = mapView
        
     // save data to populate table
        self.lat = coordinate?.latitude
        self.lon = coordinate?.longitude
        self.tit = "selected"
        
     //call method to save location
        saveLocation(self)
        
    }

    
    // UI gesture recognizer for tap press
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if (gestureRecognizer is UITapGestureRecognizer)
        {
            return true
        }
        else {
                return false
             }
    }

    //Provide pop to user to save location, taking title details and populate the table
    @IBAction func saveLocation(_ sender: Any) {
        
        let refreshAlert = UIAlertController(title: "Location", message: "Want to save this location", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("User agree to save location")
            
            let alert = UIAlertController(title: "Title For Location", message: "Enter a title for this Location", preferredStyle: .alert)
            
            alert.addTextField { (textField) in
                textField.text = "Location : "
            }
            
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler:  { (action: UIAlertAction!) in
                let textField = alert.textFields![0]
                print("Text field: \(textField.text ?? "no title entered")")
                self.newLocationTitle = textField.text

                //Save location
                let apDelegate = UIApplication.shared.delegate as? AppDelegate
                let mapObject = (maplocation(title: self.newLocationTitle!, newLatitiude: self.lat ?? 19.017615, newLongitutde: self.lon ?? 72.856164))
                apDelegate?.locationList.append(mapObject)
                
                
                // After saving, go back to the location table view
                _ = self.navigationController?.popViewController(animated: true)
                
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("User Cancelled on Entering Title")
                
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("User don't want to save this location")
            self.defaultMarker?.map = nil
            self.saveBtn.isEnabled = false
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    } // method ends here
    
    
    
} // class end
