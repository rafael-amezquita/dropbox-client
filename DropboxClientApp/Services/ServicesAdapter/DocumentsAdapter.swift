//
//  DocumentAdapter.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

class DocumentsAdapter: DocumentsAdapterProtocol {
    
    private let api = DropboxAPIFactory.dropboxAPI()
    
    // MARK: - Fetching
    
    func fetchDocuments(from path: String?,
                        completion: @escaping ([Document]?)->Void)  {
        api.documentList(withPath: path) { [weak self]
            response in
            let documents = self?.metadataToDocuments(response.entries)
            completion(documents)
        }
    }
    
    func getThumbnail(from path: String,
                      completion: @escaping (UIImage?)->Void) {
        api.documentThumbnail(withPath: path) {
            image in
            completion(image)
        }
    }
    
    func getContent(from path: String,
                    completion: @escaping (URL?)->Void) {
        api.documentContent(from: path) {
            url in
            
            guard let url = url else {
                completion(nil)
                return
            }
            
            completion(url)
        }
    }
    // MARK: - Mapping
    
    private func metadataToDocuments(_ metadata: [Metadata]) -> [Document] {
        var documents = [Document]()
        for element in metadata {
            let type = mapDocumentType(from: element)
            var document = Document(type: type,
                                    name: element.name,
                                    path: element.pathDisplay)
            if let file = element as? FileMetadata {
                document.size = document.formarSize(from: Float(file.size))
            }
           
            documents.append(document)
        }
        
        return documents
    }
    
    private func mapDocumentType(from element: Metadata) -> DocumentType {
        var documentType: DocumentType = .folder
        switch element {
            case _ as FileMetadata:
                documentType = .file
            case _ as FolderMetadata:
                documentType = .folder
            default:
                documentType = .unknown
        }
        
        return documentType
    }
}
