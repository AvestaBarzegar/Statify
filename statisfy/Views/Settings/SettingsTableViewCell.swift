//
//  SettingsTableViewCell.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-09.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    static let identifier = "SettingsTableViewCell"
    static let cellHeight: CGFloat = 64
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sharedLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func sharedLayout() {
        
    }

}
