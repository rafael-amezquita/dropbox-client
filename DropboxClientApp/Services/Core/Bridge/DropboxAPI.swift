//
//  ServicesWebAPI.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import SwiftyDropbox

class DropboxAPI: DropboxAPIProtocol {
    
    private let client = DropboxClientsManager.authorizedClient!
    
    // MARK: - API Handling
    
    func documentList(withPath path: String?,
                      completion: @escaping(FolderResult)->Void) {
        
        let queue = DispatchQueue(label: "documentListQueue")
        let response: DropboxRCPResponseClosure = {
            response, error in
                
            if let result = response {
                completion(result)
            }
        }
        
        client.files.listFolder(path: configure(path: path))
            .response(queue: queue,
                      completionHandler: response)
    }
    
    func documentThumbnail(withPath path: String,
                           completion: @escaping(UIImage?)->Void) {
        
        let response: DropboxDataResponseClosure = {
            response, error in
            guard let metadataResponse: (metadata: FileMetadata, data: Data) = response else {
                //TODO: Error handling
                completion(nil)
                return
            }
            
            let thumb = UIImage(data: metadataResponse.data)
            completion(thumb)
        }
        
        client.files.getThumbnail(path: path)
            .response(completionHandler: response)
    }
    
    func documentContent(from path: String,
                         completion: @escaping(URL?)->Void) {
        // Download to URL
        let fileManager = FileManager.default
        let directoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destURL = directoryURL.appendingPathComponent("temp.pdf")
        
        let destination: DestinationResponseClosure = {
            _,_ in 
            return destURL
        }
        let response: DropboxFileResponseClosure = {
            response, error in
            if let metadataResponse:(metadata: FileMetadata, url: URL) = response  {
                completion(metadataResponse.url)
            } else if let _ = error {
                completion(nil)
            }
        }
        
        client.files.download(path: path,
                              overwrite: true,
                              destination: destination)
            .response(completionHandler: response)
    }
    
    
    // MARK: - Configuration
    
    private func configure(path: String?) -> String {
        var selectedPath = ""
        if let path = path {
            selectedPath = "/\(path)"
        }
        return selectedPath
    }
    
}
