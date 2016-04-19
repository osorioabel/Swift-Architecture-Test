//
//  CoordinatorType.swift
//  Swift Architecture
//
//  Created by Abel Osorio on 4/19/16.
//  Copyright © 2016 Kogi Mobile. All rights reserved.
//

import Foundation
import UIKit

protocol Transitionable: class {
    var navigationCoordinator: CoordinatorType? { get set }
}

protocol CoordinatorType: class {
    var baseController: UIViewController { get }
    
    func performTransition(transition: Transition)
}

enum Transition {
    
    case SignIn
    
}
