//
//  SignInCoordinator.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation
import UIKit

class SignInCoordinator: CoordinatorType {
    
    var baseController: UIViewController
    weak var delegate: CoordinatorType?
    
    init() {
        baseController = UIViewController()
    }
    
    func performTransition(transition: Transition) {
        _ = baseController as? UINavigationController
        
        switch transition {
       
        default:
            delegate?.performTransition(transition)
        }
    }
}