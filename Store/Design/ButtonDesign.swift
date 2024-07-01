//
//  ButtonDesign.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit

final class OrangeButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.whiteColor, for: .normal)
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        backgroundColor = .themeColor
        layer.cornerRadius = 25
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

