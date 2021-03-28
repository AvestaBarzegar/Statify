//
//  SectionHeaderView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-28.
//

import UIKit

class SectionHeaderView: UIView {
    
    // MARK: - Interaction Logic

    var delegate: SectionHeaderViewDelegate?
    
    @objc
    func leftButtonClicked() {
        delegate?.leftButtonClicked()
    }
    
    @objc
    func rightButtonClicked() {
        delegate?.rightButtonClicked()
    }
    
    // MARK: - Init Views
    
    var info: SectionHeaderViewModel? {
        didSet {
            headerLabel.text = info?.title
            
            if let leftImageName = info?.leftImageName {
                leftButtonView.addTarget(self, action: #selector(leftButtonClicked), for: .touchUpInside)
                let leftImage = UIImage(systemName: leftImageName)
                leftButtonView.setImage(leftImage, for: .normal)
            }
            
            if let rightImageName = info?.rightImageName {
                rightButtonView.addTarget(self, action: #selector(rightButtonClicked), for: .touchUpInside)
                let rightImage = UIImage(systemName: rightImageName)
                rightButtonView.setImage(rightImage, for: .normal)
            }
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
    
    private lazy var leftButtonView: UIButton = {
        let imageView = UIButton()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var rightButtonView: UIButton = {
        let imageView = UIButton()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        self.addSubview(leftButtonView)
        self.addSubview(rightButtonView)
        NSLayoutConstraint.activate([
            leftButtonView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftButtonView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            leftButtonView.widthAnchor.constraint(equalToConstant: 36),
            leftButtonView.heightAnchor.constraint(equalTo: leftButtonView.widthAnchor),
            
            rightButtonView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightButtonView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            rightButtonView.widthAnchor.constraint(equalToConstant: 36),
            rightButtonView.heightAnchor.constraint(equalTo: rightButtonView.widthAnchor),
            
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headerLabel.leftAnchor.constraint(equalTo: self.leftButtonView.leftAnchor, constant: 16),
            headerLabel.rightAnchor.constraint(equalTo: self.rightButtonView.rightAnchor, constant: -16)
        ])
    }
}

// MARK: - SectionHeaderViewDelegate methods

protocol SectionHeaderViewDelegate {
    
    func leftButtonClicked()
    
    func rightButtonClicked()
}
