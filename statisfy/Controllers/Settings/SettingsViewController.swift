//
//  SettingsViewController.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-06.
//

import UIKit

class SettingsViewController: UIViewController {

    // MARK: - Data
    
    let headerInfo = SectionHeaderViewModel(title: "Settings", leftImageName: nil, rightImageName: nil)
    
    // MARK: - Initialize Views
    
    private lazy var headerView: SectionHeaderView = {
        let header = SectionHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.info = headerInfo
        return header
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        return button
    }()
    
    @objc
    func buttonClicked() {
        CustomAlertViewController.showAlertOn(self, "Error", "Could not reach server", "Try Again", cancelButtonText: "Cancel") {
            print("pressed retry")
        } cancelAction: {
            print("pressed cancel")
        }

    }
    
    // MARK: - Layout Views
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        self.view.addSubview(headerView)
        self.view.addSubview(button)
        
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight.rawValue),
            
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

}
