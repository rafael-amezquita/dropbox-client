//
//  DocumentsProtocol.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 22/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

protocol DocumentsProtocol {
        
    var numberOfItems: Int { get }
    
    @discardableResult
    func updateackwardNavigationHistory() -> String?
    
    func fetchDocuments(_ completion: @escaping (Bool)->Void)
    
    func fetchDocument(at index: Int,
                       completion: @escaping (DocumentsProtocol?, DetailsProtocol?)->Void)
    
    func cellContent(from index:Int,
                     defaultCompletion: (String?, UIImage?, String?)->Void,
                     updatedCompletion: @escaping (UIImage?)->Void)
}
