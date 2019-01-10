//
//  MyPhotoGuideUITests.swift
//  MyPhotoGuideUITests
//
//  Created by Manjunath Shivakumara on 05/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import XCTest

class MyPhotoGuideUITests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func testLoginFlow() {
//
//        feedViewController.removeCookiesOnLogout()
//        let app = XCUIApplication()
//        let webViewsQuery = app.webViews
//        sleep(12)
//        let phoneNumberUsernameOrEmailTextField = webViewsQuery/*@START_MENU_TOKEN@*/.textFields["Phone number, username, or email"]/*[[".otherElements[\"Login • Instagram\"]",".otherElements[\"main\"]",".otherElements[\"article\"].textFields[\"Phone number, username, or email\"]",".textFields[\"Phone number, username, or email\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/
//        phoneNumberUsernameOrEmailTextField.tap()
//        phoneNumberUsernameOrEmailTextField.typeText("manjunath.sk.85@gmail.com")
//        webViewsQuery/*@START_MENU_TOKEN@*/.secureTextFields["Password"]/*[[".otherElements[\"Login • Instagram\"]",".otherElements[\"main\"]",".otherElements[\"article\"].secureTextFields[\"Password\"]",".secureTextFields[\"Password\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
//        webViewsQuery.secureTextFields["Password"].typeText("Manju-Sunu$72")
//        webViewsQuery/*@START_MENU_TOKEN@*/.buttons["Log in"]/*[[".otherElements[\"Login • Instagram\"]",".otherElements[\"main\"]",".otherElements[\"article\"].buttons[\"Log in\"]",".buttons[\"Log in\"]"],[[[-1,3],[-1,2],[-1,1,2],[-1,0,1]],[[-1,3],[-1,2],[-1,1,2]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.tap()
//        sleep(3)
//        webViewsQuery/*@START_MENU_TOKEN@*/.buttons["Not Now"]/*[[".otherElements[\"Instagram\"]",".otherElements[\"main\"].buttons[\"Not Now\"]",".buttons[\"Not Now\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
//
//    }

}
