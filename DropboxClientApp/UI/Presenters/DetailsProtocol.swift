//
//  DetailsProtocol.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 24/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation

enum DetailsType {
    case pdf
    case image
    case unknown
}

protocol DetailsProtocol {
    
    var documentType: DetailsType { get }
    func documentPath() -> URL?
}
