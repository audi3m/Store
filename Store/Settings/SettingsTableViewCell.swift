//
//  SettingsTableViewCell.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit



final class SettingsTableViewCell: BaseTableViewCell {
    
    let titleLabel = UILabel()
    let countLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier) 
        
    }
     
    override func setHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
    }
    
    override func setLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(20)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    override func setUI() {
        titleLabel.font = .systemFont(ofSize: 15)
    }
    
}
