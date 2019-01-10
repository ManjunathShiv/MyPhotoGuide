//
//  LoginViewRouter.swift
//  MyPhotoGuide
//
//  Created by Manjunath Shivakumara on 10/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import UIKit

/**
 Extension for pushing the Feed View Controller
 */

extension LoginViewController {
    func pushToFeedViewController() {
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: feedVC) as? FeedViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}

