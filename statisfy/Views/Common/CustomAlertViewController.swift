//
//  CustomAlertViewController.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-06.
//

import UIKit

class CustomAlertViewController: UIViewController {

    // MARK: - Init Variables
    private var okTapped: () -> Void = {}
    private var cancelTapped: () -> Void = {}
    
    // MARK: - Init Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.backgroundComplementColor
        view.layer.cornerRadius = Constants.cornerRadius.rawValue
        return view
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.subHeaderFontBold
        label.textColor = UIColor.spotifyWhite
        label.text = "Header"
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.bodyFontBolded
        label.textColor = UIColor.spotifyWhite
        label.text = "Header"
        return label
    }()
    
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ok", for: .normal)
        button.setTitleColor(UIColor.spotifyWhite, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.subHeaderFont
        button.backgroundColor = UIColor.spotifyGreen
        button.layer.cornerRadius = Constants.cornerRadius.rawValue
        button.addTarget(self, action: #selector(okClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.spotifyGreen, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.subHeaderFont
        button.backgroundColor = UIColor.spotifyWhite
        button.layer.cornerRadius = Constants.cornerRadius.rawValue
        button.addTarget(self, action: #selector(cancelClicked), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Button Targets
    
    @objc
    private func okClicked() {
        okTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func cancelClicked() {
        cancelTapped()
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Layout Views
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        self.view.addSubview(containerView)
        self.containerView.addSubview(headerLabel)
        self.containerView.addSubview(bodyLabel)
        self.containerView.addSubview(okButton)
        self.containerView.addSubview(cancelButton)
        dismissViewOnTap()
        
        constraintContainer()
        constraintHeaderAndBody()
        constraintButtons()
    }
    
    private func dismissViewOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    private func handleTap() {
        cancelTapped()
        self.dismiss(animated: true, completion: nil)
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
            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            headerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            bodyLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 16),
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24)
        
        ])
    }
    
    private func constraintButtons() {
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -24),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            cancelButton.heightAnchor.constraint(equalToConstant: 45),
            
            okButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -16),
            okButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            okButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            okButton.heightAnchor.constraint(equalToConstant: 45)
        
        ])
    }
    
    // MARK: - Setup Function
    static func showAlertOn(_ controller: UIViewController, _ headerText: String, _ bodyText: String, _ okButtonText: String, cancelButtonText: String, okAction: @escaping () -> Void, cancelAction: @escaping () -> Void) {
        let alert = CustomAlertViewController()
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        
        alert.headerLabel.text = headerText.uppercased()
        alert.bodyLabel.text = bodyText
        
        alert.okButton.setTitle(okButtonText.uppercased(), for: .normal)
        alert.cancelButton.setTitle(cancelButtonText.uppercased(), for: .normal)
        
        alert.okTapped = okAction
        alert.cancelTapped = cancelAction
        
        controller.present(alert, animated: true)
    }
    
}
