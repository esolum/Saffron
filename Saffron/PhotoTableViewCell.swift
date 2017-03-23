//
//  PhotoTableViewCell.swift
//  Saffron
//
//  Created by Erica Solum on 3/22/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    //MARK: Properties

    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
