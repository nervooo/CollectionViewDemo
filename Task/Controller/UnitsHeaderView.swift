//
//  UnitsHeaderView.swift
//  Task
//
//  Created by Nervana Adel on 9/17/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import UIKit

class UnitsHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var expandLabel: UILabel?
    @IBOutlet weak var chaletTitleLabel: UILabel?
    @IBOutlet weak var expandCollapseButton: UIButton?
    
    var isCollapsed: Bool = true
    var callBack: ((_ collapsed: Bool?) -> Void)?
    
    @IBAction func expandCollapseButtonPressed(_ sender: Any) {
        isCollapsed = !isCollapsed
        callBack?(isCollapsed)
        if isCollapsed {
            updateUI("+")
        } else {
            updateUI("-")
        }
    }
    
    func updateUI(_ value: String) {
        expandLabel?.text = value
    }
    
//    func updateForCollapse() {
//        updateUI("+")
//        isCollapsed = true
//    }
//    
//    func updateForExpand() {
//        updateUI("-")
//        isCollapsed = false
//    }
}
