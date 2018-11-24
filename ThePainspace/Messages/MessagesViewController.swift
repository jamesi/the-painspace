//
//  MessagesViewController.swift
//  PainspaceMessages
//

import UIKit

@objc class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Parameters
    
    @objc var messages: [Message] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register table view cells
        tableView.register(UINib(nibName: String(describing: MessageTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: MessageTableViewCell.self))
        
        // Configure table view
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MessageTableViewCell.self), for: indexPath) as! MessageTableViewCell
        
        let message = messages[indexPath.row]
        
        cell.configure(forMessage: message)
        
        return cell
    }
}
