//
//  Colors.swift
//  Avail
//
//  Created by Rene De Valery on 4/14/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation
import HexColors

enum Color: String {
    case Blue = "2E97DC"
    case DarkBlue = "4D90E7"
    case LightBlue = "6BA5EB"
    case DarkPink = "C86C97"
    case LightPink = "DF7BAA"
    case DarkGreen = "sada"
    case LightGreen = "dddfs"
    case DarkYellow = "asfgf"
    case LightYellow = "dldfg"
    
    var color: UIColor {
        return UIColor.hx_colorWithHexRGBAString(self.rawValue)!
    }
}
