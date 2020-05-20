//
//  DocumentsPresenter.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation

protocol FetchDocumentDelegate: class {
    func documentsDidFetch(_ documents: [Any])
}

class DocumentsPresenter {
    
    private var adapter = DocumentsAdapter()
    private var documents = [Document]()
    
    weak var fetchDelegate: FetchDocumentDelegate?
    
    func fetchDocuments() {
        adapter.fetchDocuments { response in
            guard let response = response else { return }
            self.fetchDelegate?.documentsDidFetch(response)
        }
    }
    
    // TODO: this isn't used
    func document(at index: Int) -> Document? {
        if index < documents.count {
            return documents[index]
        }
        
        return nil
    }
}
