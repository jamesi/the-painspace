//
//  MessageCell.swift
//  ThePainspace
//
//  Created by James Ireland on 06/12/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    let bulletView = UIImageView()
    let timeLabel = UILabel()
    let bodyLabel = UILabel()
    
    let minimumFrame = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: CGSize(width: 64.0, height: 64.0))
    
    var widthConstraint: NSLayoutConstraint? = nil
    
    var message: Message? {
        didSet {
            self.timeLabel.text = message?.timestamp.messageFormatted
            self.bodyLabel.text = message?.text
            self.setNeedsLayout()
        }
    }
    
    var availableWidth: CGFloat? {
        didSet {
            self.widthConstraint?.constant = calculateWidth()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: minimumFrame)
        self.configureSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureSubviews()
    }
    
    func configureSubviews() {

        let backgroundImage = PSStyle.resizableImageOfRoundedRect(withCornerRadius: 14.0, fill: PSStyle.messageBackgroundColor());
        self.backgroundView = UIImageView(image: backgroundImage)

        let bulletImage = PSStyle.resizableImageOfRoundedRect(withCornerRadius: 5.0, fill: PSStyle.messageBulletColor());
        self.bulletView.image = bulletImage

        self.timeLabel.font = PSStyle.preferredFontForMessageTime() // caption style?
        self.timeLabel.textColor = PSStyle.messageMetadataTextColor() // caption style?
        
        self.bodyLabel.font = PSStyle.preferredFontForMessage()
        self.bodyLabel.textColor = PSStyle.messageBodyTextColor()
        self.bodyLabel.numberOfLines = 0
        self.bodyLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        self.bulletView.widthAnchor.constraint(equalToConstant: 16.0).isActive = true
        self.bulletView.heightAnchor.constraint(equalToConstant: 16.0).isActive = true
        
        let metadataRow = UIStackView.init(arrangedSubviews: [self.bulletView, self.timeLabel])
        metadataRow.axis = .horizontal
        metadataRow.spacing = 8.0
        metadataRow.translatesAutoresizingMaskIntoConstraints = false
        
        let messageColumn = UIStackView.init(arrangedSubviews: [metadataRow, self.bodyLabel])
        messageColumn.axis = .vertical
        messageColumn.spacing = 10.0
        self.contentView.addSubview(messageColumn)
        
        messageColumn.translatesAutoresizingMaskIntoConstraints = false
        messageColumn.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 14.0).isActive = true
        messageColumn.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -14.0).isActive = true
        messageColumn.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12.0).isActive = true
        messageColumn.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -14.0).isActive = true

        self.widthConstraint = self.contentView.widthAnchor.constraint(equalToConstant: calculateWidth())
        self.widthConstraint?.priority = .defaultHigh
        self.widthConstraint!.isActive = true
    }

    func calculateWidth() -> CGFloat {
        return max(availableWidth ?? 0.0, minimumFrame.width)
    }
}
