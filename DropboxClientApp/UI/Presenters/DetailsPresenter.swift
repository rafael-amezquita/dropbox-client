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
    var documentType: DetailsType { get }
    func documentPath() -> URL?
}

enum DetailsType {
    case pdf
    case image
    case unknown
}

class DetailsPresenter: DetailsProtocol {
    
    private let path: URL!
    
    var documentType: DetailsType {
        return detailsType()
    }
    
    init(from path: URL) {
        self.path = path
    }
    
    func documentPath() -> URL? {
        return path
    }
    
    private func detailsType() -> DetailsType {
        var type: DetailsType = .unknown
        if path.absoluteString.contains("pdf") {
            type = .pdf
        } else if path.absoluteString.contains("jpg") ||
            path.absoluteString.contains("png") ||
            path.absoluteString.contains("jpeg") {
            type = .image
        }
        return type
    }
    
    
}

