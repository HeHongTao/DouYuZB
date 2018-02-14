//
//  UIColor-Extenstion.swift
//  DYZB
//
//  Created by Macbook on 2017/11/23.
//  Copyright © 2017年 何洪涛. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat , b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}












