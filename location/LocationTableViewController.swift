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

    
    var locations = [maplocation]()
    
    
    @IBAction func addLocation(_ sender: Any) {
        //forward to location view controller
        performSegue(withIdentifier: "add", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //by default entry for table
        locations.append(maplocation(title: "bansal home ", newLatitiude: 28.615087, newLongitutde: 77.057606))
        
    }

    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! MyCustomCell

        cell.title.text = locations.last?.locationtitle
        
        // closure for directly share the location without entering did select row.
        cell.yourobj =
            {
                print("wd")
        
                let activityVC = UIActivityViewController(activityItems: ["hbhvh"], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = self.view
                self.present(activityVC,animated: true,completion: nil)
        }
        return cell
    }


    
    // MARK: - Table view delegates
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "detail", sender: nil)
    }
    
  
    // prepare both segues for location controller and detail controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let controller = segue.destination as! DetailViewController
            controller.locValue =  CLLocationCoordinate2DMake(19.017615,72.856164)
            
        } else if segue.identifier == "add" {
            _ = segue.destination as! LocationViewController
        }
    }
    
}
