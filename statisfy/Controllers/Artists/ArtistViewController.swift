//
//  ArtistViewController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class ArtistViewController: UIViewController, UIScrollViewDelegate {

    // MARK: - Data
    
    private var information = [TileInformationArray?](repeating: nil, count: 3)
    
    let headerInfo = SectionHeaderViewModel(title: "Top Artists", leftImageName: nil, rightImageName: nil)
    
    // MARK: - Init Views
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.collectionViewLayout = layout
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(StatisticsCollectionScrollView.self, forCellWithReuseIdentifier: StatisticsCollectionScrollView.identifier)
        view.isPagingEnabled = true
        view.backgroundColor = .backgroundColor
        return view
    }()

    private lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.menuBarItemTitles = ["Last 4 Weeks", "Last 6 Months", "All Time"]
        menu.baseViewController = self
        return menu
    }()
    
    private lazy var headerView: SectionHeaderView = {
        let header = SectionHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.info = headerInfo
        return header
    }()
    
    // MARK: - Layout Views

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        getInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: Double(Constants.animationDuration.rawValue),
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.collectionView.alpha = 1.0
                       },
                       completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.collectionView.alpha = 0
    }
    
    private func setup() {
        self.collectionView.alpha = 0
        self.view.addSubview(collectionView)
        self.view.addSubview(menuBar)
        self.view.addSubview(headerView)
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight.rawValue),
            
            menuBar.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            menuBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: MenuBarItem.menuHeight),
            
            collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func menuScrollItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
}

    // MARK: - UICollectionView Methods

extension ArtistViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return information.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticsCollectionScrollView.identifier, for: indexPath) as? StatisticsCollectionScrollView
        cell?.tracks = information[indexPath.row]?.allInfo
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        menuBar.oldIndex = menuBar.currentIndex
        menuBar.currentIndex = Int(targetContentOffset.pointee.x / view.frame.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.sliderViewLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
}

// MARK: - Networking Logic

extension ArtistViewController {
    
    private func getInformation() {
        let manager = NetworkManager()
        
        var counter = 0
        self.showSpinner(onView: self.view)
        // Fetching top tracks in the past 4 weeks
        manager.getArtists(timeRange: .shortTerm) { [weak self] short, error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.information[0] = short
                    let indexPath = IndexPath(item: 0, section: 0)
                    self?.collectionView.reloadItems(at: [indexPath])
                }
            } else {
                print(error as Any)
            }
            counter += 1
            if counter == 3 {
                self?.removeSpinner()
            }
        }
        
        // Fetching top tracks in the past 6 months
        manager.getArtists(timeRange: .mediumTerm) { [weak self] medium, error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.information[1] = medium
                    let indexPath = IndexPath(item: 1, section: 0)
                    self?.collectionView.reloadItems(at: [indexPath])
                }
            } else {
                print(error as Any)
            }
            counter += 1
            if counter == 3 {
                self?.removeSpinner()
            }
        }
        
        // Fetching top tracks of all time
        manager.getArtists(timeRange: .longTerm) { [weak self] long, error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.information[2] = long
                    let indexPath = IndexPath(item: 2, section: 0)
                    self?.collectionView.reloadItems(at: [indexPath])
                }
            } else {
                print(error as Any)
            }
            counter += 1
            if counter == 3 {
                self?.removeSpinner()
            }
        }
    }
}
