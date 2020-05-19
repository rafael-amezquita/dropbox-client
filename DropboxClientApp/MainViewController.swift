//
//  ViewController.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 18/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        print("Main")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isUserAuthenticated() {
            // show navigation
        } else {
            let loginViewController = LoginViewController()
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    private func setUp() {
        view.backgroundColor = UIColor.white
    }

    private func isUserAuthenticated() -> Bool {
        return false
    }
    
}

