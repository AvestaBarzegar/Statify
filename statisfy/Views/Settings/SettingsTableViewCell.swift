//
//  SettingsTableViewCell.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-09.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    // MARK: - Class Constants
    
    static let identifier = "SettingsTableViewCell"
    static let cellHeight: CGFloat = 80
    
    // MARK: - Init variables
    
    var settingText: String? {
        didSet {
            settingLabel.text = settingText
        }
    }
    
    // MARK: - Init Views
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.spotifyGray
        view.layer.cornerRadius = Constants.cornerRadius.rawValue
        return view
    }()
    
    private lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.spotifyWhite
        label.font = UIFont.tableCellFontBolded
        label.text = "Sample Text"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sharedLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedLayout()
    }
    
    // MARK: - Layout
    
    private func sharedLayout() {
        self.contentView.backgroundColor = UIColor.backgroundColor
        self.contentView.addSubview(containerView)
        containerView.addSubview(settingLabel)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            containerView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 24),
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            containerView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -16),
            
            settingLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            settingLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16)
        ])
    }

}
