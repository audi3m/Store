//
//  HomeTabBarController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit

final class HomeTabBarController: UITabBarController {
    
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
    }
    
    private enum TabItems: String, CaseIterable {
        case search = "검색"
        case likes = "좋아요"
        case settings = "설정"
        
        var image: UIImage {
            switch self {
            case .search:
                return .magnifyingglass
            case .likes:
                return .likeTab
            case .settings:
                return .person
            }
        }
        
        var viewController: UIViewController {
            switch self {
            case .search:
                return UINavigationController(rootViewController: SearchViewController())
            case .likes:
                return UINavigationController(rootViewController: LikeViewController())
            case .settings:
                return UINavigationController(rootViewController: SettingsViewController())
            }
        }
    }
}


