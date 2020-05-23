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
    
    func documentThumbnail(withPath path: String,
                           completion: @escaping(UIImage?)->Void) {
        client.files.getThumbnail(path: path).response {
            (metadataResponse, error) in
            
            guard let response = metadataResponse else {
                return
            }

            let fileData = response.1 as Data
            let thumb = UIImage(data: fileData)
            
            //TODO: Error handling
            completion(thumb)
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
