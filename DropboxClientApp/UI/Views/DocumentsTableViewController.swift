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
    
    // MARK: - Initialization
    
    init(with presenter: DocumentsProtocol) {
        
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        presenter.fetchDocuments() {
            didSuccess in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
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

        presenter.cellContent(from: indexPath.row, defaultCompletion: {
            title, thumb, description in
            
            DispatchQueue.main.async {
                cell.textLabel?.text = title
                cell.detailTextLabel?.text = description
                cell.imageView?.image = thumb
            }
            
        }) {
            newThumb in
            DispatchQueue.main.async {
                cell.imageView?.image = newThumb
            }
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        presenter.fetchDocument(at: indexPath.row) {
            documentsPresenter, detailsPresenter in
            
            if let presenter = documentsPresenter {
                self.presentDocumentList(from: presenter)
            }
            
            if let presenter = detailsPresenter {
                self.presentDocumentDetails(from: presenter)
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    // MARK: - Navigation Handling
    
    private func presentDocumentList(from presenter: DocumentsProtocol) {
        
        DispatchQueue.main.async {
            let documentsTableController = DocumentsTableViewController(with: presenter)
            
            self.navigationController?.pushViewController(documentsTableController,
                                                          animated: true)
        }
    }
    
    private func presentDocumentDetails(from presenter: DetailsProtocol) {
        
        DispatchQueue.main.async {
           let detailsController = DetailsViewController(from: presenter)
            
           self.navigationController?.pushViewController(detailsController,
                                                         animated: true)
        }
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent == nil {
            presenter.updateackwardNavigationHistory()
        }
        
    }
}
