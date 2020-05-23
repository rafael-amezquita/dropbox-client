//
//  DocumentsPresenter.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

class DocumentsPresenter {
    
    private var adapter = DocumentsAdapter()
    private var documents = [Document]()
    private var selectedDocument: Document?
    
    var numberOfItems: Int {
        return documents.count
    }
    
    // MARK: - Helpers
    
    private func getThumbnailIfNeeded(from path: String,
                              completion: @escaping (UIImage)->Void) {
        adapter.getThumbnail(from: path) { (image) in
            guard let image = image else { return }
            completion(image)
        }
    }

}

// MARK: - DocumentsProtocol

extension DocumentsPresenter: DocumentsProtocol {
    
    func document(at index: Int) -> Document {
        return documents[index]
    }
    
    func fetchDocuments(_ completion: @escaping ()->Void) {
        let path: String? = selectedDocument?.path
        adapter.fetchDocuments(withPath: path) { response in
            guard let response = response else { return }
            self.documents = response
            completion()
        }
    }
    
    func fetchDocument(at index: Int,
                       completion: @escaping (DocumentsProtocol)->Void) {
        selectedDocument = documents[index]
        fetchDocuments() {
            completion(self)
        }
    }
    
    func configure(cell: UITableViewCell,
                   withIndex index: Int) {
        var document = documents[index]
        cell.textLabel?.text = document.name
        cell.imageView?.image = UIImage(named: "testimage")
        
        if let path = document.path {
            if document.type == .file{
                getThumbnailIfNeeded(from: path) { (image) in
                    document.thumb = image
                    DispatchQueue.main.async {
                        cell.imageView?.image = document.thumb
                    }
                }
            }
        }
    }
}
