//
//  DropboxAPIFactory.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 21/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit


class DropboxAPIFactory {
    
    static func dropboxAPI() -> DropboxAPIProtocol {
        return DropboxAPI()
    }
}
