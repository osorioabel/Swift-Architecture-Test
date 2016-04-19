//
//  Validator.swift
//  Avail
//
//  Created by Rene De Valery on 4/12/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation

struct Validator {
    let pattern: String
    
    init(pattern: String) {
        self.pattern = pattern
    }
    
    func validate(input: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        let match = regex.rangeOfFirstMatchInString(input, options: .ReportProgress, range: NSMakeRange(0, input.characters.count))
        
        return match.location != NSNotFound
    }
}