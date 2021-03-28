//
//  SectionHeaderView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-28.
//

import UIKit

class SectionHeaderView: UIView {

    // MARK: - Init Views
    
    var title: String? {
        didSet {
            headerLabel.text = title
        }
    }
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.spotifyWhite
        label.font = UIFont.subHeaderFontBold
        label.text = "Sample Text"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Layout Views
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ])
    }
    


}
