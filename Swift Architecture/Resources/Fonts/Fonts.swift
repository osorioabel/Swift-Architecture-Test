//
//  Fonts.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation
import UIKit

enum Fonts: String {
    case BackArrow = "ic_back_arrow"
    case Background = "ic_background"
    
    var font: UIFont {
        return UIFont(name:self.rawValue, size:14.0)
    }
}
