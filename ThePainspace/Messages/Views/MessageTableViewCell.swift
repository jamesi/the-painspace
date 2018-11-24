//
//  MessageTableViewCell.swift
//  PainspaceMessages
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var messageTime: UILabel!
    @IBOutlet weak var messageBubble: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundColor = UIColor.clear
    }
    
    func configure(forMessage message: Message) {
        messageBubble.layer.cornerRadius = 16
        messageBubble.backgroundColor = UIColor.white
        
        messageText.text = message.text
        messageTime.text = message.timestamp.messageFormatted
    }
}
