//
//  DayCellTableViewCell.swift
//  Task
//
//  Created by Nervana Adel on 9/16/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import UIKit

class DayCellTableViewCell: UITableViewCell {

    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dateHijriLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
