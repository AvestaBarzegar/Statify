//
//  TopItemViewController.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-08-26.
//

import UIKit
import Combine

class TopItemViewController<T: TopItemTypeManager>: UIViewController,
        UICollectionViewDelegate,
        UICollectionViewDataSource,
        UICollectionViewDelegateFlowLayout,
        MenuBarTapDelegate {
    
    // MARK: - properties
    private let manager: T
    private lazy var headerInfo = SectionHeaderViewModel(title: manager.viewTitle.rawValue, leftImageName: nil, rightImageName: nil)
    
    private var subscriptions: Set<AnyCancellable> = []
    
    private var isLoading: Bool = true
    
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
        let titles = manager.menuBarTitles
        let menu = MenuBar(frame: .zero, titles: titles)
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.delegate = self
        return menu
    }()
    
    private lazy var headerView: SectionHeaderView = {
        let header = SectionHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.info = headerInfo
        return header
    }()
    
    init(manager: T) {
        self.manager = manager
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Layout Views
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        
        manager.statePublisher
            .receive(on: RunLoop.main	)
            .sink { [weak self] _ in
                self?.isLoading = false
                self?.collectionView.reloadData()
            }
            .store(in: &subscriptions)
        
        manager.errorPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                switch $0 {
                case .loading:
                    self?.isLoading = true
                case .valid:
                    self?.isLoading = false
                case .error(let err):
                    self?.isLoading = false
                    guard let vc = self else { return }
                    CustomAlertViewController.showAlertOn(vc, "ERROR", err, "Retry", cancelButtonText: "cancel") {
                        self?.manager.fetchData()
                    } cancelAction: {}
                }
            }
            .store(in: &subscriptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        manager.fetchData()
        UIView.animate(withDuration: Double(Constants.animationDuration.rawValue),
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                        self?.collectionView.alpha = 1.0
                       },
                       completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        collectionView.alpha = 0
    }
    
    private func setup() {
        collectionView.alpha = 0
        view.addSubview(collectionView)
        view.addSubview(menuBar)
        view.addSubview(headerView)
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerViewHeight.rawValue),
            
            menuBar.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuBar.heightAnchor.constraint(equalToConstant: MenuBarItem.menuHeight),
            
            collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CollectionView protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.state.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatisticsCollectionScrollView.identifier, for: indexPath) as? StatisticsCollectionScrollView
        let tiles = manager.state[indexPath.row].tiles
        let isLoading = manager.state[indexPath.row].isLoading
        cell?.tracks = tiles
        cell?.animating = isLoading
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
    
    // MARK: - MenuBar
    func didSelect(menuBar: MenuBar, at indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
}
