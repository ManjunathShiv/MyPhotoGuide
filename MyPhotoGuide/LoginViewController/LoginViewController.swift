//
//  LoginViewController.swift
//  MyPhotoGuide
//
//  Created by Manjunath Shivakumara on 05/01/19.
//  Copyright © 2019 Manjunath Shivakumara. All rights reserved.
//

import Foundation
import WebKit
import Alamofire

var myContext = 0

class LoginViewController: BaseViewController, WKNavigationDelegate {
    /**
     Property declaration for webview and activity indicator
     */
    weak var webView: WKWebView?
    @IBOutlet weak var webPlaceHolderView: UIView?
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    //MARK: - Load Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         Setup webview for loading the webpage
         */
        
        let webViewConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: (webPlaceHolderView?.bounds)!, configuration: webViewConfiguration)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.webPlaceHolderView?.addSubview(webView)
        self.webView = webView
        self.webPlaceHolderView?.addSubview(activity)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        /**
         Fetch Code for getting access token
         */
        self.fetchCodeToGetAccessToken()
    }
}
/**
 Extension for fetching code and access token
 */

extension LoginViewController {
    /**
     Fetch the code first from instagram API
     */
    func fetchCodeToGetAccessToken() {
        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=code", arguments: [API.INSTAGRAM_AUTHURL,API.INSTAGRAM_CLIENT_ID,API.INSTAGRAM_REDIRECT_URI, API.INSTAGRAM_SCOPE])
        let url:URL   = URL(string: authURL)!
        self.webView?.load(URLRequest(url: url))
    }
    
    /**
     This method will be called after the code is obtained
     */
    func fetchAccessToken() {
        let code = UserDefaults.standard.value(forKey: UD_redirect_code)
        let authURL : String = String(format: "%@?client_id=%@&client_secret=%@&grant_type=%@&redirect_uri=%@&code=%@&response_type=token", arguments: [API.INSTAGRAM_ACCESSURL,API.INSTAGRAM_CLIENT_ID,API.INSTAGRAM_CLIENTSECRET,"authorization_code",API.INSTAGRAM_REDIRECT_URI, code as! CVarArg])
        let url:URL   = URL(string: authURL)!
        self.webView?.load(URLRequest(url: url))
    }
    
}

/**
 Extension Web view delegate methods
 */

extension LoginViewController {
    // MARK: - WKNavigationDelegate methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation) {
        self.activity.startAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (@escaping (WKNavigationActionPolicy) -> Void)) {
        var redirectURLWithCode : String = ""
    
        /**
         Check the redirect URL for the code and access token
         */
        
        if let redirectURLString = navigationAction.request.url?.absoluteString {
            redirectURLWithCode = redirectURLString
            /**
             Save the code received in user defaults
             */
            if redirectURLWithCode.contains("code=") {
                let urlArray = redirectURLWithCode.components(separatedBy: "=")
                let code  = urlArray[1]
                UserDefaults.standard.set(code, forKey: UD_redirect_code)
            }
            /**
             Save the access token received in user defaults
             */
            if redirectURLWithCode.contains("access_token=") {
                let urlArray = redirectURLWithCode.components(separatedBy: "=")
                let token  = urlArray[1]
                UserDefaults.standard.set(token, forKey: UD_access_token)
                self.pushToFeedViewController()
            }
            
        }
        
        switch navigationAction.navigationType {
        case .linkActivated:
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
        default:
            break
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: (@escaping (WKNavigationResponsePolicy) -> Void)) {
        decisionHandler(.allow)
    }
    
    //MARK: - Webpage finish load
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
        self.activity.stopAnimating()
        let code = UserDefaults.standard.value(forKey: UD_redirect_code)
        let token = UserDefaults.standard.value(forKey: UD_access_token) as! String
        
        if code != nil &&  token == API.INSTAGRAM_ACCESS_TOKEN {
            self.fetchAccessToken()
        }
    }
    
    //MARK: - Webpage load fail
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation, withError error: Error) {
        self.activity.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation, withError error: Error) {
        self.activity.stopAnimating()
    }
}
