//
//  MessagesViewController.swift
//  ThePainspace
//

import UIKit

@objc protocol MessagesViewControllerDelegate: class {
    func messagesViewControllerDidSelectInfo()
}

class MessagesViewController: UIViewController {

    @objc weak var delegate: MessagesViewControllerDelegate? = nil
    
    @objc var messages: [Message] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    // todo: insert new rows via diff
    // todo: scroll to end
    // todo: scroll to selected notification message
    
    var tableView: UITableView?
    
    var collectionView: UICollectionView?
    
    override func loadView() {
        let mainView = UIView()
        self.view = mainView
        
        let backgroundImage = UIImageView.init(image: UIImage(named: "DefaultBackground"))
        mainView.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true

        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.estimatedItemSize = CGSize(width: 1.0, height: 1.0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        self.collectionView = collectionView
        collectionView.delegate = self
        mainView.addSubview(collectionView)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true

        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: NSStringFromClass(MessageCell.self))
        collectionView.dataSource = self
        
        self.navigationItem.titleView = buildTitleView()
        self.navigationItem.rightBarButtonItem = buildInfoBarButtonItem()
    }

    func buildTitleView() -> UIView {
        let titleView = UIView()
        titleView.backgroundColor = UIColor.clear
        
        let logoImage = UIImage(named: "ThePainspaceLogo")
        let logoView = UIImageView(image: logoImage)
        logoView.backgroundColor = UIColor.clear
        titleView.addSubview(logoView)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        let logoImageRatio = logoImage!.size.width / logoImage!.size.height
        logoView.widthAnchor.constraint(equalTo: logoView.heightAnchor, multiplier: logoImageRatio).isActive = true
        
        logoView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 0.0).isActive = true
        logoView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: 0.0).isActive = true
        logoView.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 4.0).isActive = true
        logoView.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -8.0).isActive = true

        return titleView
    }
    
    func buildInfoBarButtonItem() -> UIBarButtonItem {
        let image = UIImage(named: "InfoIcon");
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(infoButtonSelected))
        return item
    }
    
    @objc func infoButtonSelected() {
        self.delegate?.messagesViewControllerDidSelectInfo()
    }
}

extension MessagesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? messages.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MessageCell.self), for: indexPath) as! MessageCell
        cell.message = messages[indexPath.row]
        cell.availableWidth = collectionView.bounds.width - 24.0
        return cell
    }
    
}

extension MessagesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16.0, left: 12.0, bottom: 16.0, right: 12.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }

}
