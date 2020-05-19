//
//  LoginViewController.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 18/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var usernameField: UITextField!
    private var passwordField: UITextField!
    private var loginButton: UIButton!
    
    // MARK: - lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        usernameField = UITextField(frame: CGRect.zero)
        passwordField = UITextField(frame: CGRect.zero)
        loginButton = UIButton(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    // MARK: - Components Configuration
    
    private func setUpViews() {
        setUpUsernameField()
        setUpPasswordField()
        setUpLoginButton()
    }
    
    private func setUpUsernameField() {
        usernameField.frame = CGRect(x: 10, y: 10, width: 250, height: 25)
        usernameField.backgroundColor = UIColor.gray
        view.addSubview(usernameField)
       // username.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpPasswordField() {
        passwordField.frame = CGRect(x: 10, y: 45, width: 250, height: 25)
        passwordField.backgroundColor = UIColor.gray
        view.addSubview(passwordField)
       // password.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpLoginButton() {
        loginButton.frame = CGRect(x: 10, y: 80, width: 250, height: 25)
        loginButton.backgroundColor = UIColor.lightGray
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitleColor(UIColor.darkGray, for: .highlighted)
        loginButton.addTarget(self, action: #selector(login(_:)), for: .touchUpInside)
        view.addSubview(loginButton!)
       // login.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - Actions
    @objc private func login(_ sender: UIButton) {
        let navigation = NavigationViewController()
        present(navigation, animated: true, completion: nil)
    }
}
