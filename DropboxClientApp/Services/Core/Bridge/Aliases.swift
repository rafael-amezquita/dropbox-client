//
//  Aliases.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 23/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import Foundation
import SwiftyDropbox

typealias Metadata = Files.Metadata
typealias FileMetadata = Files.FileMetadata
typealias FolderMetadata = Files.FolderMetadata
typealias DownloadError = Files.DownloadError
typealias ThumbnailError = Files.ThumbnailError
typealias ListFolderResult = Files.ListFolderResult
typealias ListFolderError = Files.ListFolderError
typealias DropboxFileResponseClosure = ((FileMetadata, URL)?, CallError<DownloadError>?) -> Void
typealias DropboxDataResponseClosure = ((FileMetadata, Data)?, CallError<ThumbnailError>?) -> Void
typealias DropboxRCPResponseClosure = (ListFolderResult?, CallError<ListFolderError>?) -> Void
typealias DestinationResponseClosure = (URL, HTTPURLResponse) -> URL
