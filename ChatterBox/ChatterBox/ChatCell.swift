//
//  ChatCell.swift
//  ChatterBox
//
//  Created by Rajeev Ram on 8/26/18.
//  Copyright © 2018 Rajeev Ram. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var chatMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
