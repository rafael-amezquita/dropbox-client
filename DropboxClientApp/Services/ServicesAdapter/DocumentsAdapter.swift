//
//  DocumentAdapter.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation

class DocumentsAdapter {
    
    private let api = WebAPIFactory.serviceAPI()
    
    // MARK: - Fetching
    
    func fetchDocuments(withPath path: String?,
                        completion: @escaping ([Document]?)->Void)  {
        api.documentList(withPath: path) { response in
            //guard let response = response else { return }
            let documents = self.metadataToDocuments(response.entries)
            completion(documents)
        }
    }
    
    // MARK: - Mapping
    
    private func metadataToDocuments(_ metadata: [Metadata]) -> [Document] {
        var documents = [Document]()
        for element in metadata {
        
            let type = mapDocumentType(from: element)
            let document = Document(type: type,
                                    name: element.name,
                                    path: element.pathDisplay ?? "")
            documents.append(document)
        }
        
        return documents
    }
    
    private func mapDocumentType(from element: Metadata) -> DocumentType {
        var documentType: DocumentType = .folder
        // TODO: getThumbnail and update the model with that info
        switch element {
            case let fileMetadata as FileMetadata:
                documentType = .file
                print(fileMetadata)
            case let folderMetadata as FolderMetadata:
                documentType = .folder
                print(folderMetadata)
            default:
                documentType = .unknown
                print(element)
        }
        
        return documentType
    }
}
