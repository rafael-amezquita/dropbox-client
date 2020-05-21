//
//  WebAPIFactory.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 21/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import SwiftyDropbox

typealias FolderResult = SwiftyDropbox.Files.ListFolderResult
typealias Metadata = SwiftyDropbox.Files.Metadata
typealias FileMetadata = Files.FileMetadata
typealias FolderMetadata = Files.FolderMetadata

protocol ServicesWebAPIProtocol {
    func documentList(withPath path: String?,
                      completion: @escaping(FolderResult)->Void)
}

class WebAPIFactory {
    static func serviceAPI() -> ServicesWebAPIProtocol {
        return ServicesWebAPI()
    }
}
