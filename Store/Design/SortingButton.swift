//
//  SortingButton.swift
//  Store
//
//  Created by J Oh on 6/15/24.
//

import UIKit

enum SortOptions: String, CaseIterable {
    case sim
    case date
    case asc
    case dsc
    
    var title: String {
        switch self {
        case .sim: "정확도"
        case .date: "날짜순"
        case .asc: "가격낮은순"
        case .dsc: "가격높은순"
        }
    }
}

class SortingButton: UIButton {
    
    var option: SortOptions
    
    init(option: SortOptions) {
        self.option = option
        super.init(frame: .zero)
        setupButton()
        deSelected()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        setTitle(option.title, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
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
    
    static func blackStyle(title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.cornerStyle = .capsule
        
        return config
    }
    
}
