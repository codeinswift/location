//
//  LocationTableViewController.swift
//  location
//
//  Created by Sumit Bansal on 16/08/17.
//  Copyright © 2017 Sumit. All rights reserved.
//

import UIKit

class LocationTableViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    
    var locations = [maplocation]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  locations.append(maplocation(title: "bansal home ", newLatitiude: 28.615087, newLongitutde: 77.057606))
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationTableViewCell", for: indexPath) as UITableViewCell

cell.textLabel?.text = locations[0].locationtitle
        return cell
    }


}
