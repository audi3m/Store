//
//  SearchResultCollectionViewCell.swift
//  Store
//
//  Created by J Oh on 6/15/24.
//

import UIKit
import SnapKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .red
        
        updateImageViewAppearance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        
    }
    
    private func updateImageViewAppearance() {
        
        
    }
}
