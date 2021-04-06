//
//  CustomAlertViewController.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-06.
//

import UIKit

class CustomAlertViewController: UIViewController {

    // MARK: - Init Variables
    var okTapped: () -> Void = {}
    var cancelTapped: () -> Void = {}
    
    // MARK: - Init Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.spotifyGray
        view.layer.cornerRadius = Constants.cornerRadius.rawValue
        return view
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.subHeaderFontBold
        label.textColor = UIColor.spotifyWhite
        label.text = "Header"
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.subHeaderFont
        label.textColor = UIColor.spotifyWhite
        label.text = "Header"
        return label
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ok", for: .normal)
        button.titleLabel?.textColor = UIColor.spotifyWhite
        button.titleLabel?.font = UIFont.subHeaderFont
        button.backgroundColor = UIColor.spotifyGreen
        button.layer.cornerRadius = Constants.cornerRadius.rawValue
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.textColor = UIColor.spotifyGreen
        button.titleLabel?.font = UIFont.subHeaderFont
        button.backgroundColor = UIColor.spotifyWhite
        button.layer.cornerRadius = Constants.cornerRadius.rawValue
        return button
    }()
    
    // MARK: - Button Targets
    
    @objc
    func okClicked() {
        okTapped()
    }
    
    @objc
    func cancelClicked() {
        cancelTapped()
    }
    
    // MARK: - Layout Views
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func setup() {
        self.view.addSubview(containerView)
        self.containerView.addSubview(headerLabel)
        self.containerView.addSubview(bodyLabel)
        self.containerView.addSubview(okButton)
        self.containerView.addSubview(cancelButton)
        
        constraintContainer()
        constraintHeaderAndBody()
        constraintButtons()
    }
    
    private func constraintContainer() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32),
            containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func constraintHeaderAndBody() {
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            headerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8)
        
        ])
    }
    
    private func constraintButtons() {
        
    }
    
    

}
