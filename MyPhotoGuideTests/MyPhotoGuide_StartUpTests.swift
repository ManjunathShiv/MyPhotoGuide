//
//  MyPhotoGuide_StartUpTests.swift
//  MyPhotoGuideTests
//
//  Created by Manjunath Shivakumara on 10/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import XCTest
@testable import MyPhotoGuide

class MyPhotoGuide_StartUpTests: XCTestCase {
    var startupViewController: ViewController!
    
    override func setUp() {
        super.setUp()
        startupViewController = mainStoryboard.instantiateViewController(withIdentifier: "StartupViewController") as? ViewController
        startupViewController.view.layoutIfNeeded()
    }
    
    override func tearDown() {
        startupViewController = nil
        super.tearDown()
    }
    
    func testInstance() {
        XCTAssertNotNil(startupViewController, "Not able to create StartupViewController Instance.")
    }
    
    func testInstanceNil() {
        XCTAssertNotNil(startupViewController, "StartupViewController, instance is nil.")
    }
    
    func testAlreadyLoginScenario() {
        UserDefaults.standard.set(false, forKey: UD_is_userloggedout)
        UserDefaults.standard.set("abcd1234", forKey: UD_access_token)
        startupViewController.verifyAndRedirect()
    }
    
    func testNewLoginScenario() {
        UserDefaults.standard.set(true, forKey: UD_is_userloggedout)
        UserDefaults.standard.set(nil, forKey: UD_access_token)
        startupViewController.verifyAndRedirect()
    }
}
