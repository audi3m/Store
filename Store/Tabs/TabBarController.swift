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
         
        let search = UINavigationController(rootViewController: SearchTabViewController())
        search.tabBarItem = UITabBarItem(title: "검색", image: .magnifyingglass, tag: 0)
        
        let settings = UINavigationController(rootViewController: SettingsTabViewController())
        settings.tabBarItem = UITabBarItem(title: "설정", image: .person, tag: 1)
        
        setViewControllers([search, settings], animated: true)
        
    }
}
