//
//  LocalizableString.swift
//  Avail
//
//  Created by Rene De Valery on 4/13/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation

enum LocalizableString: String {
    
    case Learners = "Learners"
    case Notifications = "Notifications"
    case AddLearner = "Add Learner"
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
