//
//  RecenTrackTableViewCell.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-27.
//

import UIKit

class RecentTrackTableViewCell: UITableViewCell {

    static let identifier = "RecentTrackTableViewCell"
    static let cellHeight: CGFloat = 108
        
        // MARK: - Initialize and configure view variables
    var recentTrackInfo: RecentTrackInfo? {
        didSet {
            if let url = recentTrackInfo?.imgURL {
                songImage.lazyLoadImageUsingURL(urlString: url, placeholder: nil)
            }
            if let artist = recentTrackInfo?.artist {
                artistLabel.text = artist
            }
            if let track = recentTrackInfo?.track {
                trackLabel.text = track
            }
        }
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.spotifyGray
        view.layer.cornerRadius = Constants.cornerRadius.rawValue
        return view
    }()

    private lazy var trackLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.tableCellFontBolded
        label.textColor = UIColor.spotifyWhite
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.tableCellFontSemiBolded
        label.textColor = UIColor.spotifyWhite
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var songImage: DownloadedImageView = {
        let imageView = DownloadedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor.spotifyGreen
        imageView.layer.cornerRadius = Constants.cornerRadius.rawValue
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - Layout Views

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        contentView.backgroundColor = UIColor.backgroundColor
        contentView.addSubview(containerView)
        containerView.addSubview(songImage)
        containerView.addSubview(trackLabel)
        containerView.addSubview(artistLabel)
        NSLayoutConstraint.activate([
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            songImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            songImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            songImage.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            songImage.widthAnchor.constraint(equalTo: songImage.heightAnchor),
            trackLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            trackLabel.topAnchor.constraint(equalTo: songImage.topAnchor, constant: 4),
            trackLabel.rightAnchor.constraint(equalTo: songImage.leftAnchor, constant: -16),
            artistLabel.bottomAnchor.constraint(equalTo: songImage.bottomAnchor, constant: -4),
            artistLabel.leftAnchor.constraint(equalTo: trackLabel.leftAnchor),
            artistLabel.rightAnchor.constraint(equalTo: trackLabel.rightAnchor)
        ])
    }

}
