//
//  DocumentsViewModel.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

class DocumentsViewModel {
    
    private var adapter: DocumentsAdapterProtocol!
    private var documents = [Document]()
    private var selectedDocument: Document?
    private var navigationHistory = [String]()
    
    var numberOfItems: Int {
        return documents.count
    }
    
    init(withAdapter adapter: DocumentsAdapterProtocol = DocumentsAdapter()) {
        self.adapter = adapter
        navigationHistory.append("")
    }
    
    // MARK: - Document Asynchronous Update
    
    private func getThumbnailIfNeeded(from path: String,
                              completion: @escaping (UIImage)->Void) {
        adapter.getThumbnail(from: path) {
            image in
            guard let image = image else {
                return
            }
            completion(image)
        }
    }
    
    // MARK: - Configuration
    
    private func defaultContent(from document: Document,
                                defaultCompletion: (String?, UIImage?, String?)->Void) {
        var doc = document
        let image = doc.type == .file ? "file" : "folder"
        doc.thumb = UIImage(named: image)
        
        var details = "folder"
        if let size = document.size {
            details = size
        }
        defaultCompletion(document.name, doc.thumb , details)
    }

}

// MARK: - DocumentsProtocol

extension DocumentsViewModel: DocumentsProtocol {
    
    func document(at index: Int) -> Document {
        return documents[index]
    }
    
    func fetchDocuments(_ completion: @escaping (Bool)->Void) {
        adapter.fetchDocuments(from: navigationHistory.last) { [weak self]
            response in
            
            guard let response = response else {
                completion(false)
                return
            }
            
            self?.documents = response
            completion(true)
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
                _ in 
                completion(self, nil)
            }
        } else {
            if let doc = selectedDocument,
                let path = doc.path {
                adapter.getContent(from: path) {
                    url in
                    
                    guard let url = url else {
                        return
                    }
                    
                    let detailsPresenter = DetailsViewModel(from: url)
                    completion(nil, detailsPresenter)
                }
            }
        }
    }
    
    func cellContent(from index:Int,
                     defaultCompletion: (String?, UIImage?, String?)->Void,
                     updatedCompletion: @escaping ((UIImage?)->Void)) {
        
        var document = documents[index]
        guard let path = document.path else {
            defaultCompletion(nil, nil, nil)
            return
        }
        
        defaultContent(from: document,
                       defaultCompletion: defaultCompletion)
        
        if document.type == .file {
            DispatchQueue.global(qos: .background).async { [weak self] in
                self?.getThumbnailIfNeeded(from: path) {
                    image in
                    document.thumb = image
                    updatedCompletion(document.thumb)
                }
            }
        }
    }
    
    @discardableResult
    func updateackwardNavigationHistory() -> String? {
        return navigationHistory.popLast()
    }
}
