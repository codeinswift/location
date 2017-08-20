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

    var locValue: CLLocationCoordinate2D?
    var mapView : GMSMapView?

    override func viewDidLoad() {
        
        super.viewDidLoad()
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
        
        let activityVC = UIActivityViewController(activityItems: ["hbhvh"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC,animated: true,completion: nil)
    }

}
