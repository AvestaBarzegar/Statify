//
//  TrackStatisticsView.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

// Vertically scrolling scrollView
class StatisticsCollectionScrollView: UICollectionViewCell {
    
    var tracks: [TileInfo]? {
        didSet {
            collectionView.reloadData()
            if tracks == nil {
                noInformationLabel.isHidden = false
            }
            guard let tracks = tracks else { return }
            noInformationLabel.isHidden = !tracks.isEmpty
        }
    }
    
    var animating: Bool = true {
        didSet {
            if animating {
                spinner.isHidden = !animating
                spinner.isAnimating = animating
            } else {
                spinner.isHidden = !animating
                spinner.isAnimating = animating
            }
        }
    }
    
    static let identifier = "StatisticsCollectionScrollView"
    
    // MARK: - Init views
    let padding: CGFloat = 16.0
    
    private lazy var noInformationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No History Available"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.spotifyWhite
        label.font = UIFont.welcomeSubtitleFont
        label.isHidden = true
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        let layout = UICollectionViewFlowLayout()
        let width = (UIScreen.main.bounds.width - padding * 3) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = padding
        layout.scrollDirection = .vertical
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = insets
        cv.collectionViewLayout = layout
        cv.backgroundColor = UIColor.backgroundColor
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(StatisticsCollectionViewCell.self, forCellWithReuseIdentifier: StatisticsCollectionViewCell.identifier)
        return cv
    }()
    
    private lazy var spinner: ProgressView = {
        let spinner = ProgressView(colors: SpinnerColors.normal, lineWidth: 5.0)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
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
        contentView.addSubview(collectionView)
        contentView.addSubview(noInformationLabel)
        contentView.addSubview(spinner)
        NSLayoutConstraint.activate([
            noInformationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            noInformationLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 32),
            noInformationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -32),
            
            
            collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 50),
            spinner.heightAnchor.constraint(equalTo: spinner.widthAnchor)
        ])
        spinner.isAnimating = true
        noInformationLabel.isHidden = true
    }

}

extension StatisticsCollectionScrollView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let tracks = tracks else {
            return 0
        }
        return tracks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticsCollectionViewCell.identifier, for: indexPath) as? StatisticsCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let track = tracks?[indexPath.row] {
            cell.tileInfo = track
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? StatisticsCollectionViewCell
        let artist = cell?.tileInfo?.artist
        debugPrint(artist as Any)
        
    }
    
}
