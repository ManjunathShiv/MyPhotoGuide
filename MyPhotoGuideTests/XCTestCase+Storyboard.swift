//
//  XCTestCase+Storyboard.swift
//  MyPhotoGuideTests
//
//  Created by Manjunath Shivakumara on 09/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import XCTest
@testable import MyPhotoGuide

extension XCTestCase {
    /**
     * Get mainStoryboard inside XCTestCase.
     */
    var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle(for: LoginViewController.self))
    }
}
