//
//  PriceCollectionViewCell.swift
//  Task
//
//  Created by Nervana Adel on 9/16/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import UIKit

class PriceCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var chaletUnitPriceLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.greenColor?.cgColor
        self.contentView.layer.masksToBounds = true
        // Initialization code
    }

}
