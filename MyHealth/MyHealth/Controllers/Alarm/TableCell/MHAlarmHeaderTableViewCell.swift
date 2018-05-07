//
//  MHAlarmHeaderTableViewCell.swift
//  MyHealth
//
//  Created by Mai Hoang Anh on 5/7/18.
//  Copyright © 2018 Mai Hoang Anh. All rights reserved.
//

import UIKit

class MHAlarmHeaderTableViewCell: UITableViewCell {
    static let cellIdentifier = "MHAlarmHeaderTableViewCell"
    
    private var indexPath: IndexPath?
    
    var onValueChange: ((_ index: IndexPath, _ selected: Bool) -> Void)?

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var stateSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateContentCell(title: String, selected: Bool, indexPath: IndexPath) {
        self.indexPath = indexPath
        titleLabel.text = title
        stateSwitch.setOn(selected, animated: false)
    }

    @IBAction private func stateSwitchValueChanged(_ sender: Any) {
        if let onValueChange = onValueChange, let index = indexPath {
            onValueChange(index, stateSwitch.isOn)
        }
    }
    
}
