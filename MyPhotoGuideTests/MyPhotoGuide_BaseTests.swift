//
//  MyPhotoGuide_BaseTests.swift
//  MyPhotoGuideTests
//
//  Created by Manjunath Shivakumara on 09/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import XCTest
@testable import MyPhotoGuide

class BaseViewControllerTests: XCTestCase {
    var navigationController: UINavigationController!
    var baseViewController: BaseViewController {
        return self.navigationController.viewControllers[0] as! BaseViewController
    }
    
    override func setUp() {
        super.setUp()
        let baseViewController = BaseViewController(nibName: nil, bundle: nil)
        self.navigationController = UINavigationController(rootViewController: baseViewController)
    }
    
    override func tearDown() {
        navigationController = nil
        super.tearDown()
    }
    
    func testInstance() {
        XCTAssertNotNil(baseViewController, "Not able to create BaseViewController Instance.")
    }
    
    func testNavigationBarIsHiddenDefault() {
        XCTAssertFalse(baseViewController.shouldShowNavigationBar, "Navigation Bar is visible by-default.")
        baseViewController.viewWillAppear(true)
        XCTAssertEqual(baseViewController.navigationController!.isNavigationBarHidden, true, "Navigation Bar is visible after viewAppear by-default.")
    }
    
    func testNavigationBarUnHide() {
        XCTAssertFalse(baseViewController.shouldShowNavigationBar, "Navigation Bar is visible by-default.")
        baseViewController.shouldShowNavigationBar = true
        baseViewController.viewWillAppear(true)
        XCTAssertTrue(baseViewController.shouldShowNavigationBar)
        XCTAssertEqual(baseViewController.navigationController!.isNavigationBarHidden, false, "Navigation Bar is hidden after setting `shouldShowNavigationBar = true`.")
    }
    
    func testStatusBarIsVisibleDefault() {
        XCTAssertEqual(baseViewController.prefersStatusBarHidden, false, "Status Bar is hidden by-default.")
    }
    
//    func testGradientBackgroundVisibleDefault() {
//        XCTAssertTrue(baseViewController.shouldAddGradientBackground, "Gradient background is hidden by-default.")
//        baseViewController.viewDidLoad()
//        XCTAssertTrue(baseViewController.view.subviews.count > 0, "Gradient background does not exist by-default.")
//    }
    
    func testGradientBackgroundHide() {
        XCTAssertTrue(baseViewController.shouldAddGradientBackground, "Gradient background is hidden by-default.")
        baseViewController.shouldAddGradientBackground = false
        baseViewController.viewDidLoad()
        XCTAssertFalse(baseViewController.shouldAddGradientBackground, "Gradient background is visible after setting `shouldAddGradientBackground = false`.")
        XCTAssertFalse(baseViewController.view.subviews.count > 0, "Gradient background exist even after setting `shouldAddGradientBackground = false`.")
    }
    
    func testPreferredStatusBarStyle() {
        XCTAssertEqual(baseViewController.preferredStatusBarStyle, .lightContent, "Status Bar style is not `light-content`.")
    }
    
}
