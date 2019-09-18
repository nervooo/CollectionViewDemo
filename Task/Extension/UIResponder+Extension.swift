//
//  UIResponder+Extension.swift
//  Task
//
//  Created by Nervana Adel on 9/17/19.
//  Copyright © 2019 Nervana Adel. All rights reserved.
//

import UIKit

extension UIResponder {
    static var identifier: String {
        return String(describing: self)
    }
}
