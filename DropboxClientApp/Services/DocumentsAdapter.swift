//
//  DocumentAdapter.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import SwiftyDropbox

class DocumentsAdapter {
    
    private let api = ServicesWebAPI()
    
    func fetchDocuments(_ completion: @escaping ([Document]?)->Void)  {
        api.documentList { response in
            //guard let response = response else { return }
            let documents = self.metadataToDocuments(response.entries)
            completion(documents)
        }
    }
    
    private func metadataToDocuments(_ metadata: [SwiftyDropbox.Files.Metadata]) -> [Document] {
        var documents = [Document]()
        for element in metadata {
            let document = Document(name: element.name, path: element.pathDisplay ?? "")
            documents.append(document)
        }
        
        return documents
    }
}
