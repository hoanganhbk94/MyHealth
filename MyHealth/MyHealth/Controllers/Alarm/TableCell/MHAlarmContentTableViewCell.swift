//
//  MHAlarmContentTableViewCell.swift
//  MyHealth
//
//  Created by Mai Hoang Anh on 5/7/18.
//  Copyright © 2018 Mai Hoang Anh. All rights reserved.
//

import UIKit

class MHAlarmContentTableViewCell: UITableViewCell {
    static let cellIdentifier = "MHAlarmContentTableViewCell"

    @IBOutlet private  weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
