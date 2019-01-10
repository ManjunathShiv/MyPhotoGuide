//
//  FeedViewInteractor.swift
//  MyPhotoGuide
//
//  Created by Manjunath Shivakumara on 10/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import Alamofire
import WebKit

extension FeedViewController{
    
    func removeCookiesOnLogout(){
        /**
         On Logout set the userdefaults value and clear all the cookies from WEKWebview
         */
        
        UserDefaults.standard.set(true, forKey: UD_is_userloggedout)
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
    
    //MARK: - Fetch Owner Details
    
    func fetchOwnerInfo() {
        let token = UserDefaults.standard.value(forKey: UD_access_token)
        let feedURL = String(format: "%@?access_token=%@", API.INSTAGRAM_OWNERURL,token as! CVarArg)
        
        Alamofire.request(feedURL,
                          method: .get,
                          parameters: nil)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching Owner Info")
                    return
                }
                print("Owner Response - \(response)")
                
                guard let responseDict = response.result.value as? [String: Any],
                    let userProfile = responseDict["data"] as? [String:Any] else {
                        return
                }
                
                self.fetchOwnerInfoAndUpdateUI(userProfile: userProfile)
        }
    }
    
    //MARK: - Fetch Owner Feeds
    
    @objc func fetchFeedsForUser() {
        let token = UserDefaults.standard.value(forKey: UD_access_token)
        let feedURL = String(format: "%@?access_token=%@", API.INSTAGRAM_FEEDSURL,token as! CVarArg)
        
        Alamofire.request(feedURL,
                          method: .get,
                          parameters: nil)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess else {
                    print("Error while fetching remote feeds")
                    return
                }
                print("Feed Response - \(response)")
                
                guard let responseDict = response.result.value as? [String: Any],
                    let feedsList = responseDict["data"] as? [[String:Any]] else {
                        return
                }
                
                self.fetchFeedsForUserAndUpdateUI(feedsList: feedsList)
        }
    }
}

