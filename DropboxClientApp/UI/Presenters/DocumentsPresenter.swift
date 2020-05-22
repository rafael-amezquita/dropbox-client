//
//  DocumentsPresenter.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

protocol FetchDocumentDelegate: class {
    
    func documentsDidFetch()
}

protocol DocumentsProtocol {
    
    var fetchDelegate: FetchDocumentDelegate? { get set }
    var numberOfItems: Int { get }
    
    func fetchDocuments(withPath path: String?)
    func fetchDocument(at index: Int)
    func configure(cell: UITableViewCell,
                   withIndex index: Int)
}

class DocumentsPresenter {
    
    private var adapter = DocumentsAdapter()
    private var documents = [Document]()
    weak var fetchDelegate: FetchDocumentDelegate?
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
    
    func fetchDocuments(withPath path: String? = nil) {
        
        adapter.fetchDocuments(withPath: path) { response in
            guard let response = response else { return }
            self.documents = response
            self.fetchDelegate?.documentsDidFetch()
        }
    }
    
    func fetchDocument(at index: Int) {
        
        let document = documents[index]
        fetchDocuments(withPath: document.path)
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
