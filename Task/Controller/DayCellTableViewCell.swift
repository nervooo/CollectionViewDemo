//
//  DayCellTableViewCell.swift
//  Task
//
//  Created by Nervana Adel on 9/16/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import UIKit

class DayCellTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var dateHijriLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
