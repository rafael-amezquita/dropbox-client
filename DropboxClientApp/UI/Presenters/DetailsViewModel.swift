//
//  DetailsViewModel.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 23/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

class DetailsViewModel: DetailsProtocol {
    
    private let path: URL!
    
    private struct ExtensionConstants {
        static let jpg = "jpg"
        static let jpeg = "jpeg"
        static let png = "png"
        static let pdf = "pdf"
    }
    
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
        if path.absoluteString.contains(ExtensionConstants.pdf) {
            type = .pdf
        } else if path.absoluteString.contains(ExtensionConstants.jpg) ||
            path.absoluteString.contains(ExtensionConstants.png) ||
            path.absoluteString.contains(ExtensionConstants.jpeg) {
            type = .image
        }
        return type
    }
    
    
}

