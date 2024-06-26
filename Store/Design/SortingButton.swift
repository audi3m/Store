//
//  SortingButton.swift
//  Store
//
//  Created by J Oh on 6/15/24.
//

import UIKit

class SortingButton: UIButton {
    
    var option: SortOptions
    
    private var padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    
    init(option: SortOptions) {
        self.option = option
        super.init(frame: .zero)
        setupButton()
        deSelected()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
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
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
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
