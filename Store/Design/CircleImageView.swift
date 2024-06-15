//
//  CircleImageView.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

enum ImageViewType {
    case profile
    case selected
    case notSelected
    
    var borderWidth: CGFloat {
        switch self {
        case .profile: 5
        case .selected: 3
        case .notSelected: 1
        }
    }
    
    var borderColor: CGColor {
        switch self {
        case .notSelected:
            return UIColor.lightGrayColor.cgColor
        default:
            return UIColor.themeColor.cgColor
        }
    }
    
    var alpha: CGFloat {
        switch self {
        case .notSelected:
            return 0.5
        default:
            return 1
        }
    }
}

class CircleImageView: UIImageView {
    
    let camera = CameraImageView()
    
    init(image: UIImage, type: ImageViewType) {
        super.init(frame: .zero)
        
        self.image = image
        layer.borderWidth = type.borderWidth
        layer.borderColor = type.borderColor
        alpha = type.alpha
        contentMode = .scaleAspectFit
        layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

