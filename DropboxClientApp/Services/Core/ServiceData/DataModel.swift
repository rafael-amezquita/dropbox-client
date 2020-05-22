//
//  DataModel.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

enum DocumentType {
    case folder
    case file
    case unknown
}

struct Document {
    var type: DocumentType
    var name: String
    var path: String?
    var thumb: UIImage?
}
