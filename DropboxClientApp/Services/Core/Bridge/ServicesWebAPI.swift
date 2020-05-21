//
//  ServicesWebAPI.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import SwiftyDropbox


class ServicesWebAPI: ServicesWebAPIProtocol {
    
    let client = DropboxClientsManager.authorizedClient!
    
    // MARK: - API
    
    func documentList(withPath path: String?,
                      completion: @escaping(FolderResult)->Void) {
        
        client.files.listFolder(path: configure(path: path))
            .response(queue: DispatchQueue(label: "documentListQueue")) {
            response, error in
            if let result = response {
                completion(result)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func configure(path: String?) -> String {
           var selectedPath = ""
           if let path = path {
               selectedPath = "/\(path)"
           }
           
           return selectedPath
       }
    
}
