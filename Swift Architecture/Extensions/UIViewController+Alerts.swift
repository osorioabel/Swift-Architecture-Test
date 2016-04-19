//
//  UIViewController+Alerts.swift
//  Avail
//
//  Created by Rene De Valery on 4/12/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func presentDefaultAlertWithTitle(title: String?, message: String?, animated: Bool, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(okAction)
        
        presentViewController(alert, animated: animated, completion: completion)
    }
}