//
//  NavigationViewController.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    private let rootController: UIViewController!
    
    // MARK: - Initialization
    
    init() {
        let presenter = DocumentsViewModel()
        let documentsTableController = DocumentsTableViewController(with: presenter)
        rootController = documentsTableController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([rootController], animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        navigationBar.topItem?.title = "Dropbox Client"
    }
}
