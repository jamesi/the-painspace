//
//  MessagesViewController.swift
//  ThePainspace
//

import UIKit

protocol MessagesViewControllerDelegate: class {
    func messagesViewControllerDidSelectInfo()
}

class MessagesViewController: UIViewController {

    let messagesHistory: MessagesHistory
    
    weak var delegate: MessagesViewControllerDelegate? = nil
    
    var messages: [Message] = [] {
        didSet {
            print("\(oldValue.count) old messages to \(messages.count) new messages")
            performUpdates(fromMessages: oldValue, toMessages: messages)
        }
    }
    
    // todo: scroll to end
    // todo: scroll to selected notification message
    
    var collectionView: UICollectionView?
    
    var observers: [NSObjectProtocol] = []
    
    init(messagesHistory: MessagesHistory) {
        self.messagesHistory = messagesHistory
        self.messages = messagesHistory.messages
        super.init(nibName: nil, bundle: nil)
        observers.append(NotificationCenter.default.addObserver(forName: messagesHistory.changedNotification, object: nil, queue: OperationQueue.main) { [weak self] (notification) in
            self?.handleMessagesHistoryChanged()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    deinit {
        for observer in self.observers {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
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
        collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
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

    func performUpdates(fromMessages:[Message], toMessages:[Message]) {
        let d = diff(from: fromMessages, to: toMessages)
        if (d.inserts.count > 0) {
            collectionView?.insertItems(at: indexPaths(forIndexes: d.inserts))
        }
        if (d.deletes.count > 0) {
            collectionView?.deleteItems(at: indexPaths(forIndexes: d.deletes))
        }
        if (d.moves.count > 0) {
            for (from, to) in d.moves {
                collectionView?.moveItem(at: IndexPath(item: from, section: 0), to: IndexPath(item: to, section: 0))
            }
        }
    }
    
    func indexPaths(forIndexes indexes:[Int]) -> [IndexPath] {
        return indexes.map { return IndexPath(item: $0, section: 0) }
    }
    
    @objc func infoButtonSelected() {
        self.delegate?.messagesViewControllerDidSelectInfo()
    }
    
    func handleMessagesHistoryChanged() {
        print("handleMessagesHistoryChanged")
        self.messages = messagesHistory.messages
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
