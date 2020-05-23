//
//  DetailsViewController.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 23/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit
import PDFKit

class DetailsViewController: UIViewController {
    
    private let presenter: DetailsProtocol!
    private let pdfView = PDFView()
    
    // MARK: - Initialization
    
    init(from presenter: DetailsProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        view.addSubview(pdfView)
        configureConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let url = presenter.documentPath(),
            let document = PDFDocument(url: url) {
            pdfView.autoScales = true
            pdfView.document = document
        }
    }
    
    // MARK: - Consfiguration
    
    private func configureConstraints() {
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pdfView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pdfView.rightAnchor.constraint(equalTo: view.rightAnchor),
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
