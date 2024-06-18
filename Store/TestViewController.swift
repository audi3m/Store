//
//  TestViewController.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    let button = UIButton()
    
    var like = false {
        didSet {
            navigationItem.rightBarButtonItem?.image = like ? .like : .unlike.withRenderingMode(.alwaysOriginal)
            button.setImage(like ? .like : .unlike, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "테스트"
        
        let bag = UIBarButtonItem(image: .likeUnselected,
                                   style: .plain, target: self,
                                   action: #selector(bagClicked))
        
        navigationItem.rightBarButtonItem = bag
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.size.equalTo(40)
        }
        
        button.setImage(.likeUnselected, for: .normal)
        button.addTarget(self, action: #selector(bagClicked), for: .touchUpInside)
        button.contentScaleFactor = 10
        
    }
    
    @objc func bagClicked() {
        like.toggle()
    }
    
}
