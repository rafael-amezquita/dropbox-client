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
    private let pdfView: PDFView!
    private let imageView: UIImageView!
    private let loader: UIActivityIndicatorView!
    
    // MARK: - Initialization
    
    init(from presenter: DetailsProtocol) {
        self.presenter = presenter
        pdfView = PDFView()
        imageView = UIImageView()
        loader = UIActivityIndicatorView(style: .gray)
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
        
        view.addSubview(loader)
        loader.hidesWhenStopped = true
        
        startLoader()
        configureLoaderConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let url = presenter.documentPath() else {
            return
        }
        
        switch presenter.documentType {
        case .pdf:
            configurePDFView(from: url)
        case .image:
            configureImageView(from: url)
            break
        case .unknown:
            // TODO: handle error message
            break
        }
    }
    
    // MARK: - Consfiguration
    
    private func configurePDFView(from url: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let document = PDFDocument(url: url)
            self?.pdfView.autoScales = true
            DispatchQueue.main.async {
                self?.pdfView.document = document
                self?.stopLoader()
            }
        }
    }
    
    private func configureImageView(from url: URL) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            DispatchQueue.main.async {
                self?.imageView.contentMode = .scaleAspectFit
                self?.imageView.image = UIImage(contentsOfFile: url.path)
                self?.loader.stopAnimating()
            }
        }
    }
    
    private func configureConstraints(from child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.leftAnchor.constraint(equalTo: view.leftAnchor),
            child.rightAnchor.constraint(equalTo: view.rightAnchor),
            child.topAnchor.constraint(equalTo: view.topAnchor),
            child.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func startLoader() {
        loader.startAnimating()
    }
    
    private func stopLoader() {
        loader.stopAnimating()
    }
    
    private func configureLoaderConstraints() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loader.widthAnchor.constraint(equalToConstant: 100),
            loader.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}
