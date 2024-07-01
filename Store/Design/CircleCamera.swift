//
//  CircleCamera.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import UIKit
import SnapKit

final class CameraImageView: UIView {
    
    let backgroundView = UIView()
    let smallImageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubview(smallImageView)
    }
    
    private func configLayout() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.size.equalTo(30)
        }
        
        smallImageView.snp.makeConstraints { make in
            make.center.equalTo(backgroundView)
            make.size.equalTo(20)
        }
    }
    
    private func configUI() {
        backgroundView.backgroundColor = .themeColor
        backgroundView.layer.cornerRadius = 15
        
        smallImageView.image = .camera
        smallImageView.contentMode = .scaleAspectFit
        smallImageView.tintColor = .whiteColor
    }
}
