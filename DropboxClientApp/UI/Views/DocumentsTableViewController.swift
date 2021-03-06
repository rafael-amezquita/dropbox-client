//
//  DocumentsTableViewController.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit

class DocumentsTableViewController: UITableViewController {
    
    private var presenter: DocumentsProtocol!
    private var loader: UIActivityIndicatorView!
    
    // MARK: - Initialization
    
    init(with presenter: DocumentsProtocol) {
        
        self.presenter = presenter
        loader = UIActivityIndicatorView(style: .gray)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
    
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        loader.hidesWhenStopped = true
        view.addSubview(loader)
        
        startLoader()
        configureLoaderConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        presenter.fetchDocuments() { [weak self]
            didSuccess in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return presenter.numberOfItems
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle,
                                   reuseIdentifier: "DocumentCell")

        presenter.cellContent(from: indexPath.row, defaultCompletion: { [weak self]
            title, thumb, description in
            
            DispatchQueue.main.async {
                cell.textLabel?.text = title
                cell.detailTextLabel?.text = description
                cell.imageView?.image = thumb
                self?.stopLoader()
            }
            
        }) { [weak self] newThumb in
            DispatchQueue.main.async {
                cell.imageView?.image = newThumb
                self?.stopLoader()
            }
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        startLoader()
        
        presenter.fetchDocument(at: indexPath.row) { [weak self]
            documentsPresenter, detailsPresenter in
            
            if let presenter = documentsPresenter {
                if presenter.numberOfItems == 0 {
                    self?.emtptyFolderAlert()
                } else {
                    self?.presentDocumentList(from: presenter)
                }
            }
            
            if let presenter = detailsPresenter {
                self?.presentDocumentDetails(from: presenter)
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    // MARK: - Navigation Handling
    
    private func presentDocumentList(from presenter: DocumentsProtocol) {
        
        DispatchQueue.main.async { [weak self] in
            let documentsTableController = DocumentsTableViewController(with: presenter)
            self?.stopLoader()
            self?.navigationController?.pushViewController(documentsTableController,
                                                          animated: true)
        }
    }
    
    private func presentDocumentDetails(from presenter: DetailsProtocol) {
        
        DispatchQueue.main.async { [weak self] in
            let detailsController = DetailsViewController(from: presenter)
            self?.stopLoader()
            self?.navigationController?.pushViewController(detailsController,
                                                         animated: true)
        }
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent == nil {
            presenter.updateBackwardNavigationHistory()
        }
        
    }
    
    private func emtptyFolderAlert() {
        DispatchQueue.main.async { [weak self] in
            let emptyAlert = UIAlertController(title: "Sorry",
                                               message: "This folder has no documents",
                                               preferredStyle: .alert)
            
            emptyAlert.addAction(UIAlertAction(title: "OK",
                                               style: .default,
                                               handler: nil))
            
            self?.present(emptyAlert,
                          animated: true,
                          completion: nil)
        }
    }
    
    // MARK: - configuration
    
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
