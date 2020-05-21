//
//  DocumentsPresenter.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation

protocol FetchDocumentDelegate: class {
    func documentsDidFetch()
}

protocol DocumentsProtocol {
    var documents: [Document] { get }
    func fetchDocuments(withDelegate delegate: FetchDocumentDelegate,
                        withPath path: String?)
}

//extension DocumentsProtocol {
//    func fetchDocuments(withDelegate delegate: FetchDocumentDelegate,
//                        withPath path: String = "/") { }
//}

class DocumentsPresenter: DocumentsProtocol {
    
    private var adapter = DocumentsAdapter()

    var documents = [Document]()
    
    func fetchDocuments(withDelegate delegate: FetchDocumentDelegate,
                        withPath path: String?) {
        adapter.fetchDocuments(withPath: path) { response in
            guard let response = response else { return }
            self.documents = response
            delegate.documentsDidFetch()
        }
    }
    

}
