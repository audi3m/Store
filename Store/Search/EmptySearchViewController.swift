//
//  EmptySearchViewController.swift
//  Store
//
//  Created by J Oh on 6/15/24.
//

import UIKit
import SnapKit

class EmptySearchViewController: BaseViewController {
    
    let imageView = UIImageView()
    let noLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setHierarchy() {
        view.addSubview(imageView)
        view.addSubview(noLabel)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).offset(-30)
        }
        
        noLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    override func setUI() {
        imageView.image = .empty
        imageView.contentMode = .scaleAspectFit
        
        noLabel.text = "최근 검색어가 없어요."
        noLabel.font = .systemFont(ofSize: 16, weight: .black)
    }
    
}
