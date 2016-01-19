//
//  FilterTableViewCell.swift
//  camera app
//
//  Created by MacBook Pro on 1/18/16.
//  Copyright © 2016 Peter Flanagan. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet var filterImageView: UIImageView!
    @IBOutlet var filterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
