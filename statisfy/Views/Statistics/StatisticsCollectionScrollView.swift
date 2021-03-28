//
//  TrackStatisticsView.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class StatisticsCollectionScrollView: UICollectionViewCell {
    
    var tracks: [TileInfo]?
    static let identifier = "StatisticsCollectionScrollView"
    
    // MARK: - Init views
    let padding: CGFloat = 16.0
    
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
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor)

        ])
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
    
}
