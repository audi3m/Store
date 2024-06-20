//
//  ProfileCollectionViewCell.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    let imageView = CircleImageView(image: UIImage(named: "profile_0")!, type: .selected)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateImageViewAppearance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalTo(contentView.snp.center)
            make.size.equalTo(contentView.snp.size)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateImageViewAppearance() {
        imageView.layer.borderWidth = isSelected ? 3 : 1
        imageView.layer.borderColor = isSelected ? UIColor.themeColor.cgColor : UIColor.lightGray.cgColor
        imageView.alpha = isSelected ? 1 : 0.5
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
    }
}
