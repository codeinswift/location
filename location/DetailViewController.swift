//
//  DetailViewController.swift
//  location
//
//  Created by Sumit Bansal on 18/08/17.
//  Copyright © 2017 Sumit. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import CoreLocation

class DetailViewController: UIViewController {

    var a, b : Double!
    var locValue: CLLocationCoordinate2D?
    var mapView : GMSMapView?
    var navtitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = navtitle
        
        GMSServices.provideAPIKey("AIzaSyAxESpX-APxZFx_EyHbV3-OYLunqn9wr8U")
    
    let camera = GMSCameraPosition.camera(withLatitude: (locValue!.latitude), longitude: (locValue!.longitude), zoom: 18)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
    let marker = GMSMarker(position: locValue!)
        marker.title = "sumit"
        marker.map = mapView
        
        view = mapView
    
    }

    
    
    @IBAction func shareLocation(_ sender: Any) {
        
        print("wd")
        
        if let lat = self.locValue{
            self.a = self.locValue?.latitude
            self.b = self.locValue?.longitude
            
            print(a,b)
            
            var c : String = String(format:"%.5f", a)
            var d : String = String(format:"%.5f", b)
            
            print("http://maps.google.com/?ll=\(c),\(d)")
            let activityVC = UIActivityViewController(activityItems: ["http://maps.google.com/?ll=\(c),\(d)"], applicationActivities: nil)
            
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC,animated: true,completion: nil)
        }
        
        
       // let activityVC = UIActivityViewController(activityItems: ["http://maps.google.com/?ll=\(String(describing: self.locValue?.latitude)),\(String(describing: self.locValue?.longitude))"], applicationActivities: nil)
        
        
    }

}
