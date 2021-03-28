//
//  MenuBarItem.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-27.
//

import UIKit

class MenuBarItem: UICollectionViewCell {
    
    static let identifier = "MenuBarItem"
    static let menuHeight: CGFloat = 48
    
    var current: Bool = false {
        didSet {
            if current == true {
                menuBarItemLabel.textColor = UIColor.spotifyGreen
            } else {
                menuBarItemLabel.textColor = UIColor.spotifyWhite
            }
        }
    }
    
    // MARK: - Putting information into Cell
    var menuBarItemText: String? {
        didSet {
            menuBarItemLabel.text = menuBarItemText
        }
    }
    
    // MARK: - Init views
    
    private lazy var menuBarItemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bodyFontBolded
        label.textColor = UIColor.spotifyWhite
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "REALLY LONG TEXT THAT TAKES UP A LOT OF SPACE AND IS VERY ANNOYING"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Layout views
    
    private func setup() {
        self.clipsToBounds = true
        self.contentView.addSubview(menuBarItemLabel)
        
        NSLayoutConstraint.activate([
            menuBarItemLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 6),
            menuBarItemLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -6),
            menuBarItemLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
        ])
    }
}
