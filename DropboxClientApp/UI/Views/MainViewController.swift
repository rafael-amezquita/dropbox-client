//
//  ViewController.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 18/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit
import SwiftyDropbox

class MainViewController: UIViewController {
    
    private let sharedApplication = UIApplication.shared
    private var isLogged = false

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: handle session
        let navigation = NavigationViewController()
        present(navigation, animated: true, completion: nil)
        /*
        if isUserAuthenticated() {
            // TODO: show navigation
        } else {
            callAuthorizationController()
        }
         */
    }
    
    // MARK: - Configuration
    
    private func setUp() {
        if let appDelegate = sharedApplication.delegate as? AppDelegate {
            appDelegate.autenticationDelegate = self
        }
    }

    // MARK: - Autentication handling
    
    private func isUserAuthenticated() -> Bool {
        return DropboxClientsManager.authorizedClient != nil ? false : true
    }
    
    private func callAuthorizationController() {
        DropboxClientsManager.authorizeFromController(sharedApplication,
            controller: self,
            openURL: { [weak self]
            url in
                
            self?.sharedApplication.open(url)
        })
    }
}
 
// MARK: - AuthenticationDelagete

extension MainViewController: AuthenticationDelagete {
    
    func didLoginSuccesfully(_ success: Bool) {
        isLogged = success
        if success {
            let navigation = NavigationViewController()
            present(navigation, animated: true, completion: nil)
        } else {
            // TODO: handle error
        }
    }
}

