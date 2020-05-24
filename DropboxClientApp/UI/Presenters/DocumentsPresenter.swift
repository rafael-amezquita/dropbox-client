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
    private var navigationHistory = [String]()
    
    var numberOfItems: Int {
        return documents.count
    }
    
    init() {
        navigationHistory.append("")
    }
    // MARK: - Document Asynchronous Update
    
    private func getThumbnailIfNeeded(from path: String,
                              completion: @escaping (UIImage)->Void) {
        adapter.getThumbnail(from: path) { (image) in
            guard let image = image else { return }
            completion(image)
        }
    }
    
    // MARK: - Configuration
    
    private func configureData(from cell: UITableViewCell,
                               document: Document) {
        var imageName = "folder"
        if document.type == .file {
            imageName = "file"
        }
        cell.textLabel?.text = document.name
        cell.imageView?.image = UIImage(named: imageName)
        
        // TODO: show folder if it is a folder, show size
        // and another useful info if it is a file
        cell.detailTextLabel?.text = document.path
    }

}

// MARK: - DocumentsProtocol

extension DocumentsPresenter: DocumentsProtocol {
    
    func document(at index: Int) -> Document {
        return documents[index]
    }
    
    func fetchDocuments(_ completion: @escaping ()->Void) {
        adapter.fetchDocuments(withPath: navigationHistory.last) { response in
            guard let response = response else { return }
            self.documents = response
            completion()
        }
    }
    
    func fetchDocument(at index: Int,
                       completion: @escaping (DocumentsProtocol?, DetailsProtocol?)->Void) {
        selectedDocument = documents[index]
        if selectedDocument?.type == .folder {
            
            if let path = selectedDocument?.path,
                !navigationHistory.contains(path) {
                navigationHistory.append(path)
            }
            
            fetchDocuments() {
                completion(self, nil)
            }
        } else {
            if let doc = selectedDocument,
                let path = doc.path {
                adapter.getContent(from: path) { url in
                    guard let url = url else {
                        return
                    }
                    let detailsPresenter = DetailsPresenter(from: url)
                    completion(nil, detailsPresenter)
                }
            }
        }
    }
    
    func configure(cell: UITableViewCell,
                   withIndex index: Int) {
        var document = documents[index]
        configureData(from: cell, document: document)
        
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
    
    @discardableResult
    func updateackwardNavigationHistory() -> String? {
        return navigationHistory.popLast()
    }
}
