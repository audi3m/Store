//
//  TabBarController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor
        
        tabBar.tintColor = .themeColor
        tabBar.unselectedItemTintColor = .gray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGrayColor.cgColor
        tabBar.clipsToBounds = false
         
        let search = UINavigationController(rootViewController: SearchViewController())
        search.tabBarItem = UITabBarItem(title: "검색", image: .magnifyingglass, tag: 0)
        
        let settings = UINavigationController(rootViewController: SettingsViewController())
        settings.tabBarItem = UITabBarItem(title: "설정", image: .person, tag: 1)
        
        setViewControllers([search, settings], animated: true)
        
    }
    
}

enum MainTab {
    case search
    case settings
    
    
    
    
}
