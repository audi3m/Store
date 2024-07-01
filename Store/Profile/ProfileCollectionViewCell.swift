//
//  ProfileCollectionViewCell.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

final class ProfileCollectionViewCell: BaseCollectionViewCell {
    let imageView = CircleImageView(image: UIImage(named: "profile_0")!, type: .selected)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateImageViewAppearance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    override func setHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints { make in
            make.center.equalTo(contentView.snp.center)
            make.size.equalTo(contentView.snp.size)
        }
    }
    
    private func updateImageViewAppearance() {
        imageView.layer.borderWidth = isSelected ? 3 : 1
        imageView.layer.borderColor = isSelected ? UIColor.themeColor.cgColor : UIColor.lightGray.cgColor
        imageView.alpha = isSelected ? 1 : 0.5
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
    }
    
}
