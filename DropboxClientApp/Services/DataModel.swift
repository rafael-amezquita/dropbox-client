//
//  DataModel.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation

enum DocumentType {
    case folder
    case file
}

struct Document {
    var type: DocumentType
    var name: String
    var path: String
}
