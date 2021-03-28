//
//  MenuBar.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-03-27.
//

import UIKit

class MenuBar: UIView {

    // MARK: - Handling Cell information and states
    var menuBarItemTitles: [String]?
    
    var sliderViewLeftAnchorConstraint: NSLayoutConstraint?
    
    var currentIndex: Int = 0
    
    // MARK: - Init views
    
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 3
        let height: CGFloat = MenuBarItem.menuHeight
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.contentInset = insets
        cv.collectionViewLayout = layout
        cv.backgroundColor = UIColor.backgroundColor
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    let sliderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        setupCollectionView()
        self.addSubview(contentView)
        self.addSubview(sliderView)
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            
            sliderView.heightAnchor.constraint(equalToConstant: 2),
            sliderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            sliderView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/3)
        ])
        sliderViewLeftAnchorConstraint = sliderView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
        sliderViewLeftAnchorConstraint?.isActive = true
    }
    
    private func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MenuBarItem.self, forCellWithReuseIdentifier: MenuBarItem.identifier)
    }
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarItem.identifier, for: indexPath) as? MenuBarItem else { return UICollectionViewCell() }
        if indexPath.row == currentIndex {
            cell.current = true
        }
        
        cell.menuBarItemText = menuBarItemTitles?[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let oldIndexPath = IndexPath(row: currentIndex, section: 0)
        guard let oldCell = collectionView.cellForItem(at: oldIndexPath) as? MenuBarItem else { return }
        oldCell.current = false
        
        currentIndex = indexPath.row
        guard let selectedCell = collectionView.cellForItem(at: indexPath) as? MenuBarItem else { return }
        selectedCell.current = true
        
        let newLocation = CGFloat(indexPath.item) * frame.width / 3
        sliderViewLeftAnchorConstraint?.constant = newLocation
        
        UIView.animate(
            withDuration: 0.75,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1.5,
            options: .curveEaseOut,
            animations: {
                self.layoutIfNeeded()
            },
            completion: nil)
    }
    
}
