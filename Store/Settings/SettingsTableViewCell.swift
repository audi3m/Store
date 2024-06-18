//
//  SettingsTableViewCell.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

class AccountTableViewCell: UITableViewCell {
    
    let ud = UserDefaultsHelper.shared
    lazy var profileImageView = CircleImageView(image: UIImage(named: ud.profile ?? "profile_0")!, type: .selected)
    let stackView = UIStackView()
    let nicknameLabel = UILabel()
    let registerDateLabel = UILabel()
    let underBar = UIView()
    let chevronImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.addArrangedSubview(nicknameLabel)
        stackView.addArrangedSubview(registerDateLabel)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(underBar)
        contentView.addSubview(chevronImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.size.equalTo(80)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.leading.equalTo(profileImageView.snp.trailing).offset(30)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
            make.size.equalTo(25)
        }
        
        underBar.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(1)
        }
        
        profileImageView.layer.cornerRadius = 40
        
        nicknameLabel.text = "옹골찬 고래밥"
        nicknameLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        
        registerDateLabel.text = "2024. 06. 15. 가입"
        registerDateLabel.font = .systemFont(ofSize: 13)
        registerDateLabel.textColor = .grayColor
        
        
        chevronImageView.image = .chevronRight
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .grayColor
        
        underBar.backgroundColor = .darkGrayColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


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
        
        countLabel.font = .systemFont(ofSize: 15)
        
        
        underBar.backgroundColor = .darkGrayColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
