//
//  MyCustomCellTableViewCell.swift
//  location
//
//  Created by Sumit Bansal on 18/08/17.
//  Copyright © 2017 Sumit. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {
    
    
    var yourobj : (() -> Void)? = nil

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnAction(_ sender: Any) {
    
        print("cexed")
        if let btnAction = self.yourobj
        {
            btnAction()
        }
    
    }
    
}
