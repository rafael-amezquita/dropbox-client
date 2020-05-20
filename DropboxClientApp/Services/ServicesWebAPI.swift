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
    
    func documentList(_ completion: @escaping(SwiftyDropbox.Files.ListFolderResult)->Void) {
        
        client.files.listFolder(path: "").response(queue: DispatchQueue(label: "documentListQueue")) {
            response, error in
            if let result = response {
                completion(result)
            }
        }
    }
}
