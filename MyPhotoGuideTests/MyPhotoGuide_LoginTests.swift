//
//  MyPhotoGuide_LoginTests.swift
//  MyPhotoGuideTests
//
//  Created by Manjunath Shivakumara on 09/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import XCTest
@testable import MyPhotoGuide

class MyPhotoGuide_LoginTests: XCTestCase {
    var loginViewController: LoginViewController!
    
    override func setUp() {
        super.setUp()
        loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        loginViewController.view.layoutIfNeeded()
    }
    
    override func tearDown() {
        loginViewController = nil
        super.tearDown()
    }
    
    func testInstance() {
        XCTAssertNotNil(loginViewController, "Not able to create LoginViewController Instance.")
    }
    
    func testfetchCode() {
        loginViewController.fetchCodeToGetAccessToken()
        XCTAssertNotNil(loginViewController, "LoginViewController, instance is nil.")
    }
    
    func testfetchAccessToken() {
        UserDefaults.standard.set("abcd", forKey: UD_redirect_code)
        loginViewController.fetchAccessToken()
        XCTAssertNotNil(loginViewController, "LoginViewController, instance is nil.")
        
        loginViewController.pushToFeedViewController()
    }
}
