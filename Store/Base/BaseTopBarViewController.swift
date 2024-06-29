//
//  BaseTopBarViewController.swift
//  Store
//
//  Created by J Oh on 6/29/24.
//

import UIKit
import SnapKit

class BaseTopBarViewController: UIViewController {
    
    let ud = UserDefaultsHelper.shared
    
    let topBar = {
        let view = UIView()
        view.backgroundColor = .lightGrayColor
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.hideKeyboardWhenTappedAround()
        
        view.addSubview(topBar)
        topBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        setHierarchy()
        setLayout()
        setUI()
    }
    
    func setHierarchy() { }
    func setLayout() { }
    func setUI() { }
    
}
