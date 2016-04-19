//
//  RootCoordinator.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation
import UIKit

class RootCoordinator: CoordinatorType {
    
    var baseController: UIViewController
    
    init() {
        baseController = UINavigationController()
    }
    
    func performTransition(transition: Transition) {
        let navigationController = baseController as! UINavigationController
        
        switch transition {
        case .SignIn:
            let signInCoordinator = SignInCoordinator()
            signInCoordinator.delegate = self
            navigationController.presentViewController(signInCoordinator.baseController, animated: false, completion: nil)
        default:
            print("Transition not supported")
        }
    }
}