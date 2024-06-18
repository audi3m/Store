//
//  SortingButton2.swift
//  Store
//
//  Created by J Oh on 6/17/24.
//

import UIKit

class SortingButton2: UIButton {
    
    var option: SortOptions
    
    init(option: SortOptions) {
        self.option = option
        super.init(frame: .zero)
        setupButton()
        deSelected()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        setTitle(option.title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.darkGrayColor.cgColor
    }
    
    func selected() {
        backgroundColor = .darkGrayColor
        setTitleColor(.whiteColor, for: .normal)
    }
    
    func deSelected() {
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
    }
    
}

extension UIButton.Configuration {
    
    static func blackStyle() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = "로그인"
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .purple
        config.baseForegroundColor = .yellow
        return config
        
    }
}
