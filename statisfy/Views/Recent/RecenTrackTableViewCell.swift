//
//  RecenTrackTableViewCell.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-27.
//

import UIKit

class RecenTrackTableViewCell: UITableViewCell {

    private lazy var artistLabel: UILabel = {
        
    }()
    
    
    // MARK: - Layout Views
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
    }

}
