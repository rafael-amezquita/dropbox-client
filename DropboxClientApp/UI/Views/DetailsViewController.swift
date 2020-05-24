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
    private let imageView = UIImageView()
    
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
            
        switch presenter.documentType {
        case .pdf:
            view.addSubview(pdfView)
            configureConstraints(from: pdfView)
        case .image:
            view.addSubview(imageView)
            configureConstraints(from: imageView)
            break
        case .unknown:
            // TODO: handle error message
            break
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let url = presenter.documentPath() else {
            return
        }
        switch presenter.documentType {
        case .pdf:
            let document = PDFDocument(url: url)
            pdfView.autoScales = true
            pdfView.document = document
        case .image:
            imageView.image = UIImage(contentsOfFile: url.path)
            imageView.contentMode = .scaleAspectFit
            break
        case .unknown:
            // TODO: handle error message
            break
        }
        
        
    }
    
    // MARK: - Consfiguration
    
    private func configureConstraints(from child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.leftAnchor.constraint(equalTo: view.leftAnchor),
            child.rightAnchor.constraint(equalTo: view.rightAnchor),
            child.topAnchor.constraint(equalTo: view.topAnchor),
            child.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
