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
        
        presenter.fetchDocuments() {
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

        presenter.configure(cell: cell,
                            withIndex: indexPath.row)
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        presenter.fetchDocument(at: indexPath.row) {
            docuentsPresenter, detailsPresenter in
            
            if let presenter = docuentsPresenter {
                DispatchQueue.main.async {
                    let documentsTableController = DocumentsTableViewController(with: presenter)
                    self.navigationController?.pushViewController(documentsTableController,
                                                                  animated: true)
                }
            }
            
            if let presenter = detailsPresenter {
                DispatchQueue.main.async {
                   let detailsController = DetailsViewController(from: presenter)
                   self.navigationController?.pushViewController(detailsController,
                                                                 animated: true)
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
