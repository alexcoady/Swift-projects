//
//  NameAndColorCell.swift
//  8: Table cells
//
//  Created by Alex Coady on 13/02/2015.
//  Copyright (c) 2015 Alex Coady. All rights reserved.
//

import UIKit

class NameAndColorCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    
    var name: String = "" { didSet { if (name != oldValue) { nameLabel.text = name } } }
    var color: String = "" { didSet { if (color != oldValue) { colorLabel.text = color } } }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
