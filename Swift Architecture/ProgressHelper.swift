//
//  ProgressHelper.swift
//  Avail
//
//  Created by Rene De Valery on 4/18/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation
import SVProgressHUD

struct ProgressHelper {
    
    static func setupUI() {
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
        SVProgressHUD.setForegroundColor(Color.LightBlue.color)
    }
    
    static func show() {
        SVProgressHUD.show()
    }
    
    static func dismiss() {
        SVProgressHUD.dismiss()
    }
}
