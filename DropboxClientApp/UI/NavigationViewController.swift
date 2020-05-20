//
//  NavigationViewController.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    init() {
        let presenter = DocumentsPresenter()
        let documentsTableController = DocumentsTableViewController(with: presenter)
        super.init(rootViewController: documentsTableController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
