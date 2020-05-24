//
//  DocumentsAdapterProtocol.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 24/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

protocol DocumentsAdapterProtocol {
    func  getThumbnail(from path: String,
                         completion: @escaping (UIImage?)->Void)
    
    func fetchDocuments(from path: String?,
                        completion: @escaping ([Document]?)->Void)
    
    func getContent(from path: String,
                    completion: @escaping (URL?)->Void)
}
