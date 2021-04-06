//
//  SectionHeaderView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-28.
//

import UIKit

class SectionHeaderView: UIView {
    
    // MARK: - Interaction Logic

    weak var delegate: SectionHeaderViewDelegate?
    
    @objc
    func didSelectLeftButton() {
        delegate?.didSelectLeftButton()
    }
    
    @objc
    func didSelectRightButton() {
        delegate?.didSelectRightButton()
    }
    
    // MARK: - Init Views
    
    var info: SectionHeaderViewModel? {
        didSet {
            headerLabel.text = info?.title
            
            if let leftImageName = info?.leftImageName {
                let configuration = UIImage.SymbolConfiguration(pointSize: 30)
                leftButtonView.addTarget(self, action: #selector(didSelectLeftButton), for: .touchUpInside)
                let leftImage = UIImage(systemName: leftImageName, withConfiguration: configuration)
                leftButtonView.setImage(leftImage, for: .normal)
                leftButtonView.imageView?.tintColor = UIColor.spotifyWhite
            }
            
            if let rightImageName = info?.rightImageName {
                let configuration = UIImage.SymbolConfiguration(pointSize: 30)
                rightButtonView.addTarget(self, action: #selector(didSelectRightButton), for: .touchUpInside)
                let rightImage = UIImage(systemName: rightImageName, withConfiguration: configuration)
                rightButtonView.setImage(rightImage, for: .normal)
                rightButtonView.imageView?.tintColor = UIColor.spotifyWhite
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
            leftButtonView.widthAnchor.constraint(equalToConstant: Constants.buttonSize.rawValue),
            leftButtonView.heightAnchor.constraint(equalTo: leftButtonView.widthAnchor),
            
            rightButtonView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightButtonView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            rightButtonView.widthAnchor.constraint(equalToConstant: Constants.buttonSize.rawValue),
            rightButtonView.heightAnchor.constraint(equalTo: rightButtonView.widthAnchor),
            
            headerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            headerLabel.leftAnchor.constraint(equalTo: self.leftButtonView.leftAnchor, constant: 16),
            headerLabel.rightAnchor.constraint(equalTo: self.rightButtonView.rightAnchor, constant: -16)
        ])
    }
}

// MARK: - SectionHeaderViewDelegate methods

protocol SectionHeaderViewDelegate: AnyObject {
    
    func didSelectLeftButton()
    
    func didSelectRightButton()
}
