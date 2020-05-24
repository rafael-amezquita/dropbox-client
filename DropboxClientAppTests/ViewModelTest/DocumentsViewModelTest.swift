//
//  DocumentsViewModelTest.swift
//  DropboxClientAppTests
//
//  Created by Rafael Amezquita on 24/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import XCTest
@testable import DropboxClientApp

class DocumentsViewModelTest: XCTestCase {
    
    var presenter: DocumentsProtocol!
    
    override func setUpWithError() throws {
        
        let mockedAdapter = MockAdapter()
        presenter = DocumentsPresenter(withAdapter: mockedAdapter)
    }
    
    func testFetchDocuments_responseShouldBeTrue() {
        fetchAllDocuments {
            didSuccess in
            
            XCTAssertTrue(didSuccess)
        }
    }
    
    func testNumberOfItems_shouldBeGreaterThanZero() {
        fetchAllDocuments { [unowned self]
            _ in

            XCTAssertGreaterThan(self.presenter.numberOfItems, 0)
        }
    }
    
    // TODO: Make it testable
    func testCellConfirat() {
        fetchAllDocuments { [unowned self]
            _ in
            
            for index in 0 ..< self.presenter.numberOfItems {
                self.presenter.cellContent(from: index, defaultCompletion: {
                    title, thumb, description in
                    XCTAssertNotNil(title)
                    XCTAssertNotNil(thumb)
                    XCTAssertNotNil(description)
                }) { updatedThumb in
                    XCTAssertNotNil(updatedThumb)
                }
            }
        }
    }
    
    func testFetchDocument_shouldReturnDocumentsPresenter() {
        fetchAllDocuments { [unowned self]
            _ in
            self.presenter.fetchDocument(at: 0) {
                documentsPresenter, detailsPresenter in
                XCTAssertNil(detailsPresenter, "no file selected, only document list")
                XCTAssertNotNil(documentsPresenter)
            }
        }
    }
    
    // TODO: create a new adapter or modify the adapter to return the details presenter
//    func testFetchDocument_shouldReturnDetailsPresenter() {
//        presenter.fetchDocument(at: 0) {
//            documentsPresenter, detailsPresenter in
//            XCTAssertNil(documentsPresenter, "as there is no list this presenter should be nil")
//        }
//    }
    
    // MARK: - Helpers
    
    func fetchAllDocuments(_ completion: @escaping(Bool)->Void) {
        
        presenter.fetchDocuments() {
            didSuccess in
            completion(didSuccess)
        }
    }

}
