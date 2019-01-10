//
//  MyPhotoGuide_FeedTests.swift
//  MyPhotoGuideTests
//
//  Created by Manjunath Shivakumara on 09/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import XCTest
@testable import MyPhotoGuide

class MyPhotoGuide_FeedTests: XCTestCase {
    var feedViewController: FeedViewController!
    
    override func setUp() {
        super.setUp()
        feedViewController = mainStoryboard.instantiateViewController(withIdentifier: "FeedViewController") as? FeedViewController
        feedViewController.view.layoutIfNeeded()
    }
    
    override func tearDown() {
        feedViewController = nil
        super.tearDown()
    }
    
    func testInstance() {
        XCTAssertNotNil(feedViewController, "Not able to create FeedViewController Instance.")
    }
    
    func testfetchCode() {
        XCTAssertNotNil(feedViewController, "FeedViewController, instance is nil.")
    }
}
