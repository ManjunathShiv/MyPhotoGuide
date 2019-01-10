//
//  ViewControllerRouter.swift
//  MyPhotoGuide
//
//  Created by Manjunath Shivakumara on 10/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import Foundation

extension ViewController{
    func verifyAndRedirect() {
        let isloggedOut : Bool = UserDefaults.standard.bool(forKey: UD_is_userloggedout)
        let token = UserDefaults.standard.value(forKey: UD_access_token)
        let tokenStr = token as? String
        
        /**
         Checking if the logout button is pressed and if token is nil
         */
        if (isloggedOut == true || token == nil ||  tokenStr == API.INSTAGRAM_ACCESS_TOKEN) {
            /**
             Redirect to Login and clear the code and access token, and reset logout
             */
            UserDefaults.standard.set(false, forKey: UD_is_userloggedout)
            UserDefaults.standard.set(API.INSTAGRAM_ACCESS_TOKEN, forKey: UD_access_token)
            UserDefaults.standard.set(nil, forKey: UD_redirect_code)
            self.performSegue(withIdentifier: baseToLoginSegue, sender: nil)
        } else {
            /**
             Redirect to Dashboard if the token is available
             */
            self.performSegue(withIdentifier: baseToDashboardSegue, sender: nil)
        }
    }
}
