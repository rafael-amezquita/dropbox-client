//
//  AppDelegate.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 18/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit
import SwiftyDropbox

protocol AuthenticationDelagete: class {
    func didLoginSuccesfully(_ success:Bool)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    weak var autenticationDelegate: AuthenticationDelagete?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        DropboxClientsManager.setupWithAppKey("5ssd5f1mp8cl5sx")
        
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: - Dropbox Authentication
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            switch authResult {
            case .success:
                // "Success! User is logged into Dropbox."
                autenticationDelegate?.didLoginSuccesfully(true)
            case .cancel:
                // "Authorization flow was manually canceled by user!"
                autenticationDelegate?.didLoginSuccesfully(false)
            case .error(_, let description):
                print("Error: \(description)")
            }
        }
        return true
    }



}

