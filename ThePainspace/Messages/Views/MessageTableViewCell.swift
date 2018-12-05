//
//  MessageTableViewCell.swift
//  PainspaceMessages
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var icon: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.clear
    }
    
    func configure(forMessage message: Message) {
        icon.layer.cornerRadius = 5
        icon.backgroundColor = PSStyle.messageBulletColor()
        
        messageBubble.layer.cornerRadius = 14
        messageBubble.backgroundColor = PSStyle.messageBackgroundColor()
        
        messageText.text = message.text
        messageText.font = PSStyle.preferredFontForMessage()
        messageText.textColor = PSStyle.messageBodyTextColor()
        
        messageTime.text = message.timestamp.messageFormatted
        messageTime.font = PSStyle.preferredFontForMessageTime()
        messageTime.textColor = PSStyle.messageMetadataTextColor()
    }
}
