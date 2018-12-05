//
//  IntroViewController.swift
//  ThePainspace
//
//  Created by Jin Cong & Nick Taras on 24/11/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

import UIKit

@objc protocol IntroViewControllerDelegate: class {
    func introViewControllerDidFinish()
}

class IntroViewController: UIViewController {

    @objc weak var delegate: IntroViewControllerDelegate? = nil

    var text: String = ""
    var imageName: String = "DefaultBackground"
    var textColor: UIColor = PSStyle.darkTextColor()
    var timer: Timer? = nil
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    init(text: String, imageName: String, textColor: UIColor) {
        self.text = text
        self.imageName = imageName
        self.textColor = textColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func loadView() {
        let mainView = UIView()
        self.view = mainView
        
        let backgroundImage = UIImageView.init(image: UIImage.init(named: self.imageName))
        mainView.addSubview(backgroundImage)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        
        backgroundImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(finishPresentation)))
        backgroundImage.isUserInteractionEnabled = true
        
        let textLabel = UILabel()
        mainView.addSubview(textLabel)
        textLabel.font = PSStyle.preferredFont(forTextStyle: .title1)
        textLabel.textColor = self.textColor
        textLabel.layer.shadowColor = UIColor.black.cgColor
        textLabel.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        textLabel.layer.shadowRadius = 8.0
        textLabel.layer.shouldRasterize = true
        textLabel.layer.shadowOpacity = 0.2
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0;
        textLabel.text = self.text
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
    
        self.timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(finishPresentation), userInfo: nil, repeats: false)
    }
    
    @objc func finishPresentation() {
        self.delegate?.introViewControllerDidFinish()
    }
    
}
