//
//  EmptySearchViewController.swift
//  Store
//
//  Created by J Oh on 6/15/24.
//

import UIKit
import SnapKit

final class EmptySearchView: UIView {
    
    private let imageView = UIImageView()
    private let noLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchy()
        setLayout()
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setHierarchy()
        setLayout()
        setUI()
        
    }
    
    private func setHierarchy() {
        addSubview(imageView)
        addSubview(noLabel)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
        }
        
        noLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setUI() {
        imageView.image = UIImage(named: "empty")
        imageView.contentMode = .scaleAspectFit
        
        noLabel.text = "최근 검색어가 없어요."
        noLabel.font = .systemFont(ofSize: 16, weight: .black)
    }
}
