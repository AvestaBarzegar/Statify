//
//  TopStatisticViewController.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2021-07-05.
//

import UIKit

protocol NetworkManagerProtocol {
    
    func getInformation() { get set }
    
}

class TopStatisticViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    

    // MARK: - Data
    
    private var networkManager: NetworkManagerProtocol
    
    private var informationType = AppTabBarController.informationType
    
    private var information = [TileInformationArray?](repeating: nil, count: 3)
    
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
    
    // MARK: - Layout Views

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        networkManager.getInformation()
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
        self.title = "Top Artists"
        let safeArea = self.view.safeAreaLayoutGuide
        self.collectionView.alpha = 0
        self.view.addSubview(collectionView)
        self.view.addSubview(menuBar)
        NSLayoutConstraint.activate([
            menuBar.topAnchor.constraint(equalTo: safeArea.topAnchor),
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
