//
//  BaseViewController.swift
//  MyPhotoGuide
//
//  Created by Manjunath Shivakumara on 05/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import UIKit

/**
 The IBDesginable is used for selecting options from storyboard
 */
@IBDesignable

/**
 The Base class. This class will be subclassed my all the view controllers in the project .
 */
class BaseViewController: UIViewController {
    //MARK: - Properties    
    @IBInspectable
    var shouldShowNavigationBar: Bool = false
    
    @IBInspectable
    var shouldAddGradientBackground: Bool = true
    
    @IBInspectable
    var shouldShowStatusBar: Bool = true
    
    var gradientLayer: CAGradientLayer!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigationBar()
        if shouldAddGradientBackground {
            self.addGradientBackgroundColor()
        }
    }
    
    //MARK: - Status Bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
}

/**
 This Extension adds the gradient background based on the Screen requirement
 */

//MARK: - Add Background Gradient
extension BaseViewController {
    func addGradientBackgroundColor() {
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [primaryColor.cgColor, secondaryColor.cgColor]
        self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

/**
 The Extension shows/hides the navigtion bar and styles the navigation bar
 */

//MARK: - Setup Navigation Bar
extension BaseViewController {
    func setupNavigationBar() {
        if shouldShowNavigationBar {
            self.styleNavigationBar()
        }
        self.navigationController?.setNavigationBarHidden(!shouldShowNavigationBar, animated: true)
    }
    
    func styleNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        if shouldAddGradientBackground {
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.tintColor = .white
        } else {
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.navigationBar.tintColor = .white
        }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let uidFont = UIFont.init(name: helvetica_font, size: 20.0)
        guard let font = uidFont else { return }
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
    }
}
