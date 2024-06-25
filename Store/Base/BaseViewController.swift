//
//  BaseUIViewController.swift
//  Store
//
//  Created by J Oh on 6/25/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.hideKeyboardWhenTappedAround()
        
        setHierarchy()
        setLayout()
        setUI()
    }
    
    func setHierarchy() { }
    func setLayout() { }
    func setUI() { }
    
    
    
}
