//
//  WelcomeViewController.swift
//  ThePainspace
//
//  Created by James Ireland on 02/12/2018.
//  Copyright © 2018 The Painspace. All rights reserved.
//

import UIKit

@objc protocol WelcomeViewControllerDelegate: class {
    func welcomeViewControllerDidSelectContinue()
}

@objc class WelcomeViewController: UIViewController {

    @objc weak var delegate: WelcomeViewControllerDelegate? = nil

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
        
        let headingLabel = UILabel()
        headingLabel.font = PSFont.preferredFont(forTextStyle: .title1)
        headingLabel.textColor = PSStyle.lightTextColor()
        headingLabel.textAlignment = .center
        headingLabel.numberOfLines = 0;
        headingLabel.text = NSLocalizedString("WELCOME_HEADING", comment: "")
        headingLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        let bodyLabel = UILabel()
        bodyLabel.font = PSFont.preferredFont(forTextStyle: .body)
        bodyLabel.textColor = PSStyle.darkTextColor()
        bodyLabel.textAlignment = .center
        bodyLabel.numberOfLines = 0;
        bodyLabel.text = NSLocalizedString("WELCOME_BODY", comment: "")
        
        let continueButton = UIButton()
        continueButton.setTitle(NSLocalizedString("WELCOME_CONTINUE", comment: ""), for: .normal)
        continueButton.titleLabel?.font = PSFont.preferredFont(forTextStyle: .body)
        continueButton.addTarget(self, action: #selector(continueButtonSelected), for: .touchUpInside)
        
        let stackView = UIStackView.init(arrangedSubviews: [headingLabel, bodyLabel, continueButton])
        mainView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 28.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 28.0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -28.0).isActive = true
    }
    
    @objc func continueButtonSelected() {
        self.delegate?.welcomeViewControllerDidSelectContinue()
    }

}
