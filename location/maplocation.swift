//
//  location.swift
//  location
//
//  Created by Sumit Bansal on 16/08/17.
//  Copyright © 2017 Sumit. All rights reserved.
//

import Foundation
import UIKit

class maplocation
{

    var locationtitle : String? = nil
    var latitude : Double? = nil
    var longitude : Double? = nil
    
    
    
    init(title : String, newLatitiude : Double, newLongitutde : Double) {
        
        self.locationtitle = title
        self.latitude = newLatitiude
        self.longitude =  newLongitutde

        
    }
}
