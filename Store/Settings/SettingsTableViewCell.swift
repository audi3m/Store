//
//  SettingsTableViewCell.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit



class SettingsTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let countLabel = UILabel()
    let underBar = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(underBar)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(20)
        }
        
        countLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-20)
        }
        
        underBar.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(1)
        }
        
        titleLabel.font = .systemFont(ofSize: 15) 
        underBar.backgroundColor = .darkGrayColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
