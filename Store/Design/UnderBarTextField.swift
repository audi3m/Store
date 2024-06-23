//
//  UnderBarTextField.swift
//  Store
//
//  Created by J Oh on 6/23/24.
//

import UIKit
import SnapKit

class UnderBarTextField: UITextField {
    
    private let underBar = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUnderBar()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUnderBar()
    }

    private func setupUnderBar() {
        addSubview(underBar)
 
        underBar.backgroundColor = .lightGrayColor

        // Use SnapKit to set up the constraints
        underBar.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
}
