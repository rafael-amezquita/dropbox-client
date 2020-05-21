//
//  DocumentsTableViewController.swift
//  DropboxClientApp
//
//  Created by Rafael Amezquita on 19/05/20.
//  Copyright © 2020 Rafael Amezquita. All rights reserved.
//

import UIKit

class DocumentsTableViewController: UITableViewController {
    
    private let presenter: DocumentsProtocol!
    private var documents: [Any] {
        return presenter.documents
    }
    
    // MARK: - Lifecycle
    
    init(with presenter: DocumentsProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        presenter.fetchDocuments(withDelegate: self, withPath: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        // TODO: this needs to be return by presenter
        return documents.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default,
                                   reuseIdentifier: "DocumentCell")

        // Configure the cell...
        // TODO: this needs to be return by presenter
        if let document = documents[indexPath.row] as? Document {
            cell.textLabel?.text = document.name
        }

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        guard let document = documents[indexPath.row] as? Document else {
            return
        }
        
        presenter.fetchDocuments(withDelegate: self,
                                 withPath: document.name)
    }
}

extension DocumentsTableViewController: FetchDocumentDelegate {
    
    func documentsDidFetch() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
