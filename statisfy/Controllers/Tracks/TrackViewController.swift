//
//  AlbumViewController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class TrackViewController: UIViewController, UIScrollViewDelegate {
    
    let numOfPages: CGFloat = 3
    
    let track1 = TrackInfo(title: "Silver Soul", position: 1, imgURL: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png")
    let track2 = TrackInfo(title: "Zebra", position: 2, imgURL: "https://homepages.cae.wisc.edu/~ece533/images/arctichare.png")
    let track3 = TrackInfo(title: "Space Song", position: 3, imgURL: "https://homepages.cae.wisc.edu/~ece533/images/boat.png")
    
    private lazy var fourWeekTracks: [TrackInfo] = {
        var tracks: [TrackInfo] = []
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        return tracks
    }()
    
    private lazy var sixMonthTracks: [TrackInfo] = {
        var tracks: [TrackInfo] = []
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        
        return tracks
    }()
    
    private lazy var allTimeTracks: [TrackInfo] = {
        var tracks: [TrackInfo] = []
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        tracks.append(track1)
        tracks.append(track2)
        tracks.append(track3)
        
        return tracks
    }()
    
    // MARK: - Init Views
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.delegate = self
        view.isPagingEnabled = true
        view.backgroundColor = .backgroundColor
        return view
    }()
    
    private lazy var fourWeeksView: TrackStatisticsView = {
        let view = TrackStatisticsView()
        view.tracks = fourWeekTracks
        return view
    }()
    
    private lazy var sixMonthView: TrackStatisticsView = {
        let view = TrackStatisticsView()
        view.tracks = sixMonthTracks
        return view
    }()
    
    private lazy var allTimeView: TrackStatisticsView = {
        let view = TrackStatisticsView()
        view.tracks = allTimeTracks
        return view
    }()
    
    // MARK: - Layout Views

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    private func setup() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(fourWeeksView)
        scrollView.addSubview(sixMonthView)
        scrollView.addSubview(allTimeView)
        let safeArea = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.width * numOfPages, height: scrollView.bounds.height)
        fourWeeksView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        sixMonthView.frame = CGRect(x: scrollView.bounds.width, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        allTimeView.frame = CGRect(x: scrollView.bounds.width * 2, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
