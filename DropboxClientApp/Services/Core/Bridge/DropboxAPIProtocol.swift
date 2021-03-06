//
//  DropboxAPIProtocol.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 24/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import UIKit

protocol DropboxAPIProtocol {
    func documentList(withPath path: String?,
                      completion: @escaping(ListFolderResult)->Void)
    
    func documentThumbnail(withPath path: String,
                      completion: @escaping(UIImage?)->Void)
    
    func documentContent(from path: String,
                         completion: @escaping(URL?)->Void)
}
