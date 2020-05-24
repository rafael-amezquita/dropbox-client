//
//  NavigationViewController.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    // MARK: - Initialization
    
    init() {
        let presenter = DocumentsViewModel()
        let documentsTableController = DocumentsTableViewController(with: presenter)
        super.init(rootViewController: documentsTableController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modalPresentationStyle = .overFullScreen
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationBar.topItem?.title = "Dropbox Client"
    }
}
