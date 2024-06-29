//
//  AccountTableViewCell.swift
//  Store
//
//  Created by J Oh on 6/22/24.
//

import UIKit
import SnapKit

class AccountTableViewCell: BaseTableViewCell {
    
    let ud = UserDefaultsHelper.shared
    lazy var profileImageView = CircleImageView(image: UIImage(named: ud.profile ?? "profile_0")!, type: .selected)
    let stackView = UIStackView()
    let nicknameLabel = UILabel()
    let registerDateLabel = UILabel()
    let chevronImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStackView()
    }
    
    override func setHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(chevronImageView)
    }
    
    override func setLayout() {
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
        
    }
    
    override func setUI() {
        profileImageView.layer.cornerRadius = 40
        
        nicknameLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
        registerDateLabel.font = .systemFont(ofSize: 15)
        registerDateLabel.textColor = .grayColor
        
        chevronImageView.image = .chevronRight
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .grayColor
        
    }
    
    private func setStackView() {
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.addArrangedSubview(nicknameLabel)
        stackView.addArrangedSubview(registerDateLabel)
    }
}
