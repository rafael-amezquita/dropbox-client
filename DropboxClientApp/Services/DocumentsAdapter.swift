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
    typealias Metadata = SwiftyDropbox.Files.Metadata
    
    func fetchDocuments(withPath path: String?,
                        completion: @escaping ([Document]?)->Void)  {
        api.documentList(withPath: path) { response in
            //guard let response = response else { return }
            let documents = self.metadataToDocuments(response.entries)
            completion(documents)
        }
    }
    
    private func metadataToDocuments(_ metadata: [Metadata]) -> [Document] {
        var documents = [Document]()
        for element in metadata {
            let document = Document(type: .folder,
                                    name: element.name,
                                    path: element.pathDisplay ?? "")
            documents.append(document)
        }
        
        return documents
    }
}
