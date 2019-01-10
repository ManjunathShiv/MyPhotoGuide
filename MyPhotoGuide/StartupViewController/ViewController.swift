//
//  ViewController.swift
//  MyPhotoGuide
//
//  Created by Manjunath Shivakumara on 05/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import UIKit

/**
 This class subclasses the Base View and styles the UI and redirects to login or dashboard
 */

class ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         Set user defaults of logout to false
         */
        UserDefaults.standard.set(false, forKey: UD_is_userloggedout)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.verifyAndRedirect()
    }
}

