//
//  ServicesWebAPI.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import SwiftyDropbox

class ServicesWebAPI {
    let client = DropboxClientsManager.authorizedClient!
    typealias FolderResult = SwiftyDropbox.Files.ListFolderResult
    
    func documentList(withPath path: String?,
                      completion: @escaping(FolderResult)->Void) {
        
        var selectedPath = ""
        if let path = path {
            selectedPath = "/\(path)"
        }
        
        client.files.listFolder(path: selectedPath)
            .response(queue: DispatchQueue(label: "documentListQueue")) {
                
            response, error in
            if let result = response {
                completion(result)
            }
        }
    }
}
