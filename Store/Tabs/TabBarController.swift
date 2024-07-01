//
//  TabBarController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor
        
        tabBar.tintColor = .themeColor
        tabBar.unselectedItemTintColor = .gray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGrayColor.cgColor
        tabBar.clipsToBounds = false
        
        let viewControllers = TabItems.allCases.map { tabItem -> UIViewController in
            let viewController = tabItem.viewController
            viewController.tabBarItem = UITabBarItem(title: tabItem.rawValue, image: tabItem.image, tag: 0)
            return viewController
        }
        
        self.viewControllers = viewControllers
        
//        let search = UINavigationController(rootViewController: SearchViewController())
//        search.tabBarItem = UITabBarItem(title: "검색", image: .magnifyingglass, tag: 0)
//        
//        let settings = UINavigationController(rootViewController: SettingsViewController())
//        settings.tabBarItem = UITabBarItem(title: "설정", image: .person, tag: 1)
//        
//        setViewControllers([search, settings], animated: true)
        
    }
    
}

enum TabItems: String, CaseIterable {
    case search = "검색"
    case settings = "설정"
    
    var image: UIImage {
        switch self {
        case .search:
            return .magnifyingglass
        case .settings:
            return .person
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .search:
            return UINavigationController(rootViewController: SearchViewController())
//            return SearchViewController()
        case .settings:
            return UINavigationController(rootViewController: SettingsViewController())
//            return SettingsViewController()
        }
    }
    
}
