//
//  TitleCollectionViewCell.swift
//  Task
//
//  Created by Nervana Adel on 9/16/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var chaletUnitTitleLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.grayColor?.cgColor
        self.contentView.layer.masksToBounds = true
    }

}
