//
//  LocationTableViewController.swift
//  location
//
//  Created by Sumit Bansal on 16/08/17.
//  Copyright © 2017 Sumit. All rights reserved.
//

import UIKit
import CoreLocation

class LocationTableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    var passDetailValue : CLLocationCoordinate2D?
    var passTitle : String?
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    let apDelegate = UIApplication.shared.delegate as? AppDelegate
    
    
    @IBAction func addLocation(_ sender: Any) {
        //forward to location view controller
        performSegue(withIdentifier: "add", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableViewOutlet.reloadData()
    }

    
    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (apDelegate?.locationList.count)!
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! MyCustomCell

        cell.title.text = apDelegate?.locationList[indexPath.row].locationtitle
        
        // closure for directly share the location without entering did select row.
               cell.yourobj =
            {

                let activityVC = UIActivityViewController(activityItems: ["http://maps.google.com/?ll=\(String(describing: self.apDelegate?.locationList[indexPath.row].latitude)),\(String(describing: self.apDelegate?.locationList[indexPath.row].longitude))"], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = self.view
                self.present(activityVC,animated: true,completion: nil)
        }
        return cell
    }
    
    // MARK: - Table view delegates
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.passTitle = self.apDelegate?.locationList[indexPath.row].locationtitle
        self.passDetailValue = CLLocationCoordinate2D(latitude: (self.apDelegate?.locationList[indexPath.row].latitude)!,longitude: (self.apDelegate?.locationList[indexPath.row].longitude)!)
        
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
  
    // prepare both segues for location controller and detail controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let controller = segue.destination as! DetailViewController
            controller.locValue =  self.passDetailValue
            controller.navtitle = passTitle
            
        } else if segue.identifier == "add" {
            _ = segue.destination as! LocationViewController
        }
    }
    
}
