//
//  BaseTableViewCell.swift
//  Store
//
//  Created by J Oh on 6/25/24.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setHierarchy()
        setLayout()
        setUI()
    }
     
    func setHierarchy() { }
    func setLayout() { }
    func setUI() { }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
}
