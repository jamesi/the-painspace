//
//  MessagesViewController.swift
//  ThePainspace
//

import UIKit

class MessagesViewController: UIViewController {

    @objc var messages: [Message] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    // todo: insert new rows via diff
    // todo: scroll to end
    // todo: scroll to selected notification message
    
    var tableView: UITableView?
    
    override func loadView() {
        let mainView = UIView()
        self.view = mainView
        
        let backgroundImage = UIImageView.init(image: UIImage.init(named: "DefaultBackground"))
        mainView.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true

        self.tableView = UITableView()
        mainView.addSubview(tableView!)
        tableView!.backgroundColor = UIColor.clear
        tableView!.separatorStyle = .none
        tableView!.allowsSelection = false
        tableView!.translatesAutoresizingMaskIntoConstraints = false
        tableView!.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        tableView!.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        tableView!.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        tableView!.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true

        tableView!.register(UINib(nibName: String(describing: MessageTableViewCell.self), bundle: nil), forCellReuseIdentifier: NSStringFromClass(MessageTableViewCell.self))
        tableView!.dataSource = self
        
        self.navigationItem.titleView = buildTitleView()
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func buildTitleView() -> UIView {
        let titleView = UIView()
        
        let logoImage = UIImage(named: "ThePainspaceLogo")
        let logoView = UIImageView(image: logoImage)
        titleView.addSubview(logoView)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        let logoImageRatio = logoImage!.size.width / logoImage!.size.height
        logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: logoImageRatio).isActive = true
        
        logoView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 4.0).isActive = true
        logoView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -4.0).isActive = true
        logoView.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 4.0).isActive = true
        logoView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -4.0).isActive = true

        return titleView
    }
}

extension MessagesViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? messages.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(MessageTableViewCell.self), for: indexPath) as! MessageTableViewCell
        let message = messages[indexPath.row]
        cell.configure(forMessage: message)
        return cell
    }
}
