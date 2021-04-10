//
//  AccountCardView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-04-09.
//

import UIKit

class AccountCardView: UIView {
    
    // Spotify image - left: from top to bottom: email, name, follower count
    
    // MARK: - Init Views
    
    private lazy var profileImageView: DownloadedImageView = {
        let imageView = DownloadedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.spotifyGray
        imageView.layer.cornerRadius = Constants.cornerRadius.rawValue
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.subHeaderFont
        label.textColor = UIColor.spotifyWhite
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "THIS IS AN EMAIL LABEL"
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bodyFontBolded
        label.textColor = UIColor.spotifyWhite
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "THIS IS A NAME LABEL"
        return label
    }()
    
    private lazy var followerCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.bodyFontBolded
        label.textColor = UIColor.spotifyGreen
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "THIS IS A FOLLOWER COUNT LABEL"
        return label
    }()
    
    
    // MARK: - Initializer

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sharedLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Layout Views
    
    private func sharedLayout() {
        self.layer.cornerRadius = Constants.cornerRadius.rawValue
        self.addSubview(profileImageView)
        self.addSubview(emailLabel)
        self.addSubview(nameLabel)
        self.addSubview(followerCountLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.heightAnchor.constraint(equalToConstant: 48.0),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor),
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8.0),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            emailLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8),
            emailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            
            nameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8),
            nameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8.0),
            
            followerCountLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 8),
            followerCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8.0),
        ])
    }
}
