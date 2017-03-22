//
//  FollowingTableViewCell.swift
//  Saffron
//
//  Created by Erica Solum on 2/16/17.
//  Copyright © 2017 Erica Solum. All rights reserved.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var shortDesc: UITextView!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
