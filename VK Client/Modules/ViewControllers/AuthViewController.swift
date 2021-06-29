//
//  ViewController.swift
//  VK Client
//
//  Created by Сергей Беляков on 06.06.2021.
//

import UIKit
import WebKit
import SwiftKeychainWrapper

class AuthViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet weak var authWebView: WKWebView! {
        didSet {
            authWebView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = KeychainWrapper.standard.string(forKey: "vkToken") {
            Session.shared.token = token
            showMainTabBar()
            return
        }
        login()
    }
    
    private func login() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7867643"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        let request = URLRequest(url: urlComponents.url!)
        authWebView.load(request)
    }
    
    //MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                print(dict as Any)
                return dict
            }
        
        if let selfUserId = params["user_id"] {
          Session.shared.selfUserId = selfUserId
          print(Session.shared.selfUserId)
        }
        
        if let token = params["access_token"] {
            print("TOKEN = ", token as Any)
            KeychainWrapper.standard.set(token, forKey: "vkToken")
            Session.shared.token = token
            showMainTabBar()
        }
        decisionHandler(.cancel)
    }
    
    //MARK: - Routing
    
    func showMainTabBar() {
        performSegue(withIdentifier: "showHomeTabBarSegue", sender: nil)
    }
    
    
}



