//
//  ImageAsset.swift
//  Avail
//
//  Created by Rene De Valery on 4/14/16.
//  Copyright © 2016 Avail Support. All rights reserved.
//

import Foundation
import UIKit

enum ImageAsset: String {
    case BackArrow = "ic_back_arrow"
    case Background = "ic_background"
    
    case Logout = "ic_logout"
    case Notifications = "ic_notifications"
    case Plus = "ic_plus"
    
    case Logo = "ic_avail_logo"
    case Email = "ic_email"
    case FacilitatorLoginButtton = "ic_facilitator_login_button"
    case FacilitatorSignIn = "ic_facilitator_sign_in"
    case LearnerButton = "ic_learner_button"
    case Password = "ic_password"
    case SignInField = "ic_sign_in_field"
    case StartButton = "ic_start_button"
    
    case CreateTasks = "ic_create_task"
    case Tasks = "ic_tasks"
    case Folder = "ic_folder"
    case Schedule = "ic_schedule"
    case BlueArrow = "ic_blue_arrow"
    case PinkArrow = "ic_pink_arrow"
    case GreenArrow = "ic_green_arrow"
    case YellowArrow = "ic_yellow_arrow"
    
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}
