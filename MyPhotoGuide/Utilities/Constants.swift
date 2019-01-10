//
//  Constants.swift
//  MyPhotoGuide
//
//  Created by Manjunath Shivakumara on 05/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import UIKit

/**
 NAvigation Bar Tint color
 */

let navbarTintColor                  = UIColor.darkGray

/**
 Gradient Colors for the background
 */
let primaryColor   = UIColor(red: 210/255, green: 109/255, blue: 180/255, alpha: 1)
let secondaryColor = UIColor(red: 52/255, green: 148/255, blue: 230/255, alpha: 1)

/**
 The URL for instagram API
 */
struct API{
    static let INSTAGRAM_AUTHURL       = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_ACCESSURL     = "https://api.instagram.com/oauth/authorize/"
    static let INSTAGRAM_FEEDSURL      = "https://api.instagram.com/v1/users/self/media/recent/"
    static let INSTAGRAM_OWNERURL      = "https://api.instagram.com/v1/users/self/"
    static let INSTAGRAM_LOGOUT        = "https://instagram.com/accounts/logout/"
    static let INSTAGRAM_CLIENT_ID     = "77805eca867d4352afafe0afe7021093"
    static let INSTAGRAM_CLIENTSECRET  = "aa09317468b4483e88ba14c469f135a6"
    static let INSTAGRAM_REDIRECT_URI  = "http://myphotoguide.com"
    static let INSTAGRAM_ACCESS_TOKEN  = "access_token"
    static let INSTAGRAM_SCOPE         = "follower_list+public_content"
}

/**
 The User defaults Key
 */
let UD_redirect_code     = "REDIRECT_CODE"
let UD_access_token      = "ACCESS_TOKEN"
let UD_is_userloggedout  = "IS_LOGGEDOUT"

/**
 The Helvetica font
 */
let helvetica_font       = "HelveticaNeue"

/**
 The Storyboard Segue
 */

let baseToLoginSegue           = "BaseToLoginSegue"
let baseToDashboardSegue       = "BaseToDashboardSegue"

/**
 The View Controllers name
 */

let feedVC       = "FeedViewController"
