//
//  AppDestinationController.swift
//  statisfy-spotify-ios
//
//  Created by Avesta Barzegar on 2021-03-26.
//

import UIKit

class AppTabBarController: UITabBarController {
    
    // MARK: - Init Views
    
    private lazy var tabBars: [UITabBarItem] = {
        var arr = [UITabBarItem]()
        
        let firstItem = UITabBarItem()
        firstItem.title = "Top Tracks"
        
        let secondItem = UITabBarItem()
        secondItem.title = "Top Artists"
        
        let thirdItem = UITabBarItem()
        thirdItem.title = "Recent Tracks"
        
        arr.append(firstItem)
        arr.append(secondItem)
        arr.append(thirdItem)
        return arr
        
    }()
    
    private lazy var tabViewControllers: [UIViewController] = {
        var arr = [UIViewController]()
        
        let firstVC = TrackViewController()
        firstVC.tabBarItem = tabBars[0]
        
        let secondVC = ArtistViewController()
        secondVC.tabBarItem = tabBars[1]
        
        let thirdVC = RecentViewController()
        thirdVC.tabBarItem = tabBars[2]
        
        arr.append(firstVC)
        arr.append(secondVC)
        arr.append(thirdVC)
        return arr
    }()
    
    // MARK: - Layout Views
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        self.viewControllers = tabViewControllers
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
