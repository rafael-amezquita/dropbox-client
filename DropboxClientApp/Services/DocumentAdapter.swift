//
//  DocumentAdapter.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation

class DocumentsAdapter {
    
    let services = ServicesWebAPI()
    
    func documents() -> [Any] {
        
        services.documentList {_ in
            print("called")
        }
        
        return []
    }
}
