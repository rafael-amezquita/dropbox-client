//
//  MockAdapter.swift
//  DropboxClientAppTests
//
//  Created by Rafael Amezquita on 24/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit
@testable import DropboxClientApp

class MockAdapter: DocumentsAdapterProtocol {
    
    // MARK: - Fetching

    private var entriesResponse = [
        Metadata(name: "folder-a", pathLower: "/folder-a", pathDisplay: "/folder-a", parentSharedFolderId: nil),
        Metadata(name: "folder-b", pathLower: "/folder-b", pathDisplay: "/folder-b", parentSharedFolderId: nil),
        Metadata(name: "folder-c", pathLower: "/folder-c", pathDisplay: "/folder-c", parentSharedFolderId: nil)
    ]
    
    func fetchDocuments(from path: String?,
                        completion: @escaping ([Document]?)->Void)  {
        
        let documents = metadataToDocuments(entriesResponse)
        completion(documents)

    }
    
    func getThumbnail(from path: String,
                      completion: @escaping (UIImage?)->Void) {
//        api.documentThumbnail(withPath: path) {
//            image in
//            completion(image)
//        }
    }
    
    func getContent(from path: String,
                    completion: @escaping (URL?)->Void) {
//        api.documentContent(from: path) { url in
//            guard let url = url else {
//                completion(nil)
//                return
//            }
//
//            completion(url)
//        }
    }
    // MARK: - Mapping
    
    private func metadataToDocuments(_ metadata: [Metadata]) -> [Document] {
        var documents = [Document]()
        for element in metadata {
            let type = mapDocumentType(from: element)
            let document = Document(type: type,
                                    name: element.name,
                                    path: element.pathDisplay)
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

