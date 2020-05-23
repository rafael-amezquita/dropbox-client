//
//  DetailsPresenter.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 23/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsProtocol {
    func documentPath() -> URL?
}

class DetailsPresenter: DetailsProtocol {
    
    private let path: URL!
    
    init(from path: URL) {
        self.path = path
    }
    
    func documentPath() -> URL? {
        return path
    }
}

