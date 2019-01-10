//
//  FeedViewController.swift
//  MyPhotoGuide
//
//  Created by Manjunath Shivakumara on 07/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import Alamofire
import WebKit

class FeedViewController: BaseViewController {
    /**
     Property declaration for webview and activity indicator
     */
    //Constant Delaration
    let refresher = UIRefreshControl()
    var fullScreenimageView = UIImageView()
    var isZooming = false
    
    //Variable Delaration
    var userRecentUploadArray = [[String:Any]]()
    
    //Outlet Variable Delaration
    @IBOutlet var myFeedsCollectionView : UICollectionView!
    @IBOutlet var userProfilePic : UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet var logoutButton : UIButton!
    @IBOutlet var userName : UILabel!
    @IBOutlet var userFullName : UILabel!
    
    
    //MARK: - Load Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         Start Activity Indicator
         */
        
        self.activity.startAnimating()
        
        /**
         Setup UI for loading Feeds
         */
        self.setupUIForLoadingFeeds()
        
        /**
         Fetch Owner Info and Feeds of the Owner
         */
        self.fetchOwnerInfo()
        self.fetchFeedsForUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        /**
         Register for Application Did Become Active Notification
         */
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        /**
         De Register for Application Did Become Active Notification
         */
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.didBecomeActiveNotification,
            object: nil)
    }
    
    //MARK: - Application Active Methods
    
    @objc func applicationDidBecomeActive() {
        /**
         Fetch Owner Info and Feeds of the Owner when the application comes from background
         */
        self.fetchOwnerInfo()
        self.fetchFeedsForUser()
    }
    
    //MARK: - Setup UI for loading user information and feed list
    
    func setupUIForLoadingFeeds(){
        /**
        Hide the logout button
        */
        self.logoutButton.isHidden = true
        
        /**
         Setup Collection View Flow layout
         */
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: CGFloat(view.frame.size.width)-32, height: 200.0)
        flowLayout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 16
        self.myFeedsCollectionView.collectionViewLayout = flowLayout
        self.myFeedsCollectionView.showsVerticalScrollIndicator = false
        self.refresher.addTarget(self, action: #selector(fetchFeedsForUser), for: .valueChanged)
        self.myFeedsCollectionView.addSubview(self.refresher)
    }
    
    func setupUserProfile(userProfile : [String:Any]) {
        /**
        Display logout button
        */
        self.logoutButton.isHidden = false
        
        /**
         Display the user Profile Pic and name
         */
        guard let profilePicURLString : String = userProfile["profile_picture"] as? String, let profilePicURL:NSURL = NSURL(string: profilePicURLString) else {
            return
        }
        let imageData:NSData = NSData(contentsOf: profilePicURL as URL)!
        
        DispatchQueue.main.async {
            /**
             User Profile Pic Style and adding image
             */
            let image = UIImage(data: imageData as Data)
            self.userProfilePic.image = image
            self.userProfilePic.contentMode = UIView.ContentMode.scaleAspectFill
            self.userProfilePic.clipsToBounds = true
            self.userProfilePic.layer.cornerRadius = self.userProfilePic.frame.width/2.0
            self.userProfilePic.clipsToBounds = true
            
        }
        
        /**
         Adding the username and full name of the user
         */
        
        self.userName.text = userProfile["username"] as? String
        self.userFullName.text = userProfile["full_name"] as? String
        
        /**
         Stop Activity indicator
         */
        self.activity.stopAnimating()
    }
    
    //MARK: - Logout Method
    
    @IBAction func logoutBtnPressed() {
        /**
         Pop to the preview view controller
         */
        self.removeCookiesOnLogout()
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Fetch Owner Details
    
    func fetchOwnerInfoAndUpdateUI(userProfile : [String:Any]) {
        /**
         Setup user profile after success response
         */
        self.setupUserProfile(userProfile: userProfile)
    }
    
    //MARK: - Fetch Owner Feeds
    
    @objc func fetchFeedsForUserAndUpdateUI(feedsList : [[String:Any]]) {
        /**
         Setup user user feed list after success reponse
         */
        self.userRecentUploadArray = feedsList
        self.myFeedsCollectionView.reloadData()
        self.refresher.endRefreshing()
    }
}

/**
 Extension for collection view delegate and datasource method
 */

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource
{
    /**
     Number of items in a colletion view
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userRecentUploadArray.count
    }
    
    /**
     Number of sections in a collection view
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    /**
     Design and Populate the cell of collection view
     */
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell : UICollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath)
        
        /**
         Style the cell for border and shadow
         */
        
        myCell.layer.masksToBounds = false
        myCell.layer.shadowOpacity = 0.75
        myCell.layer.shadowRadius = 2.0
        myCell.layer.shadowOffset = CGSize.zero
        myCell.layer.shadowPath = UIBezierPath(rect: myCell.bounds).cgPath
        myCell.layer.shouldRasterize = false
        myCell.backgroundColor = UIColor(red: CGFloat((246.0 / 255.0)), green: CGFloat((245.0 / 255.0)), blue: CGFloat((247.0 / 255.0)), alpha: CGFloat(1.0))
        

        /**
         Extract the image for displaying
         */
        
        var thumbnailImageURLString : String = String()
        
        let imageDictionary = self.userRecentUploadArray[indexPath.row] as Dictionary
        if let imagesArray = imageDictionary["images"] as? [String:Any] {
            if let thumbnailImage = imagesArray["low_resolution"] as? [String:Any] {
                thumbnailImageURLString = (thumbnailImage["url"] as? String)!
            }
        }
        let thumbnailImageURL:NSURL = NSURL(string: thumbnailImageURLString)!
        
        /**
         Set the imageview frame
         */
        let imageView = UIImageView(frame: CGRect(x:0, y:0, width:myCell.frame.size.width, height:myCell.frame.size.height))
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            /**
             Update the UI with the image after converting it to data
             */
            
            let imageData:NSData = NSData(contentsOf: thumbnailImageURL as URL)!
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                imageView.image = image
                imageView.contentMode = UIView.ContentMode.scaleAspectFill
                imageView.clipsToBounds = true
                myCell.addSubview(imageView)
            }
        }
        
        return myCell
    }
    
    /**
     Did select row at collection view
     */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        /**
         Display the Tapped Image Link
         */
        print("User tapped on item \(indexPath.row)")
        var thumbnailImageURLString : String = String()
        
        let imageDictionary = self.userRecentUploadArray[indexPath.row] as Dictionary
        if let imagesArray = imageDictionary["images"] as? [String:Any] {
            if let thumbnailImage = imagesArray["standard_resolution"] as? [String:Any] {
                thumbnailImageURLString = (thumbnailImage["url"] as? String)!
            }
        }
        let thumbnailImageURL:NSURL = NSURL(string: thumbnailImageURLString)!
        let imageData:NSData = NSData(contentsOf: thumbnailImageURL as URL)!
        DispatchQueue.main.async {
            if let image = UIImage(data: imageData as Data) {
                /**
                 If the image is not nil open it up in full screen mode
                 */
                self.addImageViewWithImage(image: image)
            }
            
        }
    }
}

/**
 Extension for Animating the image.
 */

extension FeedViewController {
    func addImageViewWithImage(image: UIImage) {
        /**
         Display the Image in full screen
         */
        fullScreenimageView = UIImageView(frame: self.view.frame)
        fullScreenimageView.contentMode = .scaleAspectFit
        fullScreenimageView.backgroundColor = UIColor.black
        fullScreenimageView.image = image
        fullScreenimageView.isUserInteractionEnabled = true
        
        /**
         Add tap gesture for removing the image from full screen mode
         */
        
        let dismissTap = UITapGestureRecognizer(target: self, action: #selector(self.removeImage))
        dismissTap.numberOfTapsRequired = 1
        dismissTap.numberOfTouchesRequired = 1
        dismissTap.delegate = self as? UIGestureRecognizerDelegate
        fullScreenimageView.addGestureRecognizer(dismissTap)
        
        /**
         Pinch Gesture for zomming in to the image in full screen mode
         */
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinch(sender:)))
        pinch.delegate = self as? UIGestureRecognizerDelegate
        self.fullScreenimageView.addGestureRecognizer(pinch)
        
        /**
         Add the Image in full screen mode to main view
         */
        
        self.view.addSubview(fullScreenimageView)
        self.view.bringSubviewToFront(fullScreenimageView)
    }
    
    /**
     This method is for removing the image from full screen mode
     */
    
    @objc func removeImage() {
        UIView.animate(withDuration: 0.5, animations: {self.fullScreenimageView.alpha = 0.0},
                       completion: {(value: Bool) in
                        self.fullScreenimageView.removeFromSuperview()
        })
    }
    
    /**
     This method is for pinching the image for zooming
     */
    
    @objc func pinch(sender:UIPinchGestureRecognizer) {
        if sender.state == .began {
            let currentScale = self.fullScreenimageView.frame.size.width / self.fullScreenimageView.bounds.size.width
            let newScale = currentScale*sender.scale
            if newScale > 1 {
                self.isZooming = true
            }
        } else if sender.state == .changed {
            guard let view = sender.view else {return}
            let pinchCenter = CGPoint(x: sender.location(in: view).x - view.bounds.midX,
                                      y: sender.location(in: view).y - view.bounds.midY)
            let transform = view.transform.translatedBy(x: pinchCenter.x, y: pinchCenter.y)
                .scaledBy(x: sender.scale, y: sender.scale)
                .translatedBy(x: -pinchCenter.x, y: -pinchCenter.y)
            let currentScale = self.fullScreenimageView.frame.size.width / self.fullScreenimageView.bounds.size.width
            var newScale = currentScale*sender.scale
            if newScale < 1 {
                newScale = 1
                let transform = CGAffineTransform(scaleX: newScale, y: newScale)
                self.fullScreenimageView.transform = transform
                sender.scale = 1
            }else {
                view.transform = transform
                sender.scale = 1
            }
        } else if sender.state == .ended || sender.state == .failed || sender.state == .cancelled {
            UIView.animate(withDuration: 0.3, animations: {
                let center = self.fullScreenimageView.center
                self.fullScreenimageView.transform = CGAffineTransform.identity
                self.fullScreenimageView.center = center
            }, completion: { _ in
                self.isZooming = false
            })
        }
    }
}
