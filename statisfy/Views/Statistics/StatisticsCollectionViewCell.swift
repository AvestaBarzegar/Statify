//
//  TrackStatisticsCell.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

// Horizontally scrolling scrolView
class StatisticsCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StatisticsCollectionViewCell"
    
    // MARK: - Putting information into Cell
    var tileInfo: TileInfo? {
        didSet {
            if let url = tileInfo?.imgURL {
                trackImage.lazyLoadImageUsingURL(urlString: url, placeholder: nil)
            }
            if let title = tileInfo?.title {
                trackOrArtistLabel.text = title
            }
            if let placement = tileInfo?.position {
                placementLabel.text = "#\(placement)"
            }
        }
    }
    
    // MARK: - Init views
    
    private lazy var trackImage: DownloadedImageView = {
        let imageView = DownloadedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.systemGray
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadius.rawValue
        return imageView
    }()
    
    private lazy var trackOrArtistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.tableCellFontBolded
        label.textColor = UIColor.spotifyWhite
        label.numberOfLines = 4
        label.lineBreakMode = .byTruncatingTail
        label.text = "REALLY LONG TEXT THAT TAKES UP A LOT OF SPACE AND IS VERY ANNOYING"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var placementLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.tableCellFontBolded
        label.textColor = UIColor.spotifyWhite
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "REALLY LONG TEXT THAT TAKES UP A LOT OF SPACE AND IS VERY ANNOYING"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 5
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.masksToBounds = false
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
        self.contentView.addSubview(trackImage)
        trackImage.addSubview(trackOrArtistLabel)
        trackImage.addSubview(placementLabel)
        NSLayoutConstraint.activate([
            trackImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            trackImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            trackImage.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            trackImage.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            placementLabel.leftAnchor.constraint(equalTo: trackImage.leftAnchor, constant: 16),
            placementLabel.rightAnchor.constraint(equalTo: trackImage.rightAnchor, constant: -16),
            placementLabel.topAnchor.constraint(equalTo: trackImage.topAnchor, constant: 16),
            trackOrArtistLabel.leftAnchor.constraint(equalTo: placementLabel.leftAnchor),
            trackOrArtistLabel.bottomAnchor.constraint(equalTo: trackImage.bottomAnchor, constant: -16),
            trackOrArtistLabel.rightAnchor.constraint(equalTo: trackImage.rightAnchor, constant: -16)
        ])
    }
}
