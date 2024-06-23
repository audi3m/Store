//
//  AccountTableViewCell.swift
//  Store
//
//  Created by J Oh on 6/22/24.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    let ud = UserDefaultsHelper.shared
    lazy var profileImageView = CircleImageView(image: UIImage(named: ud.profile ?? "profile_0")!, type: .selected)
    let stackView = UIStackView()
    let nicknameLabel = UILabel()
    let registerDateLabel = UILabel()
    let underBar = UIView()
    let chevronImageView = UIImageView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setStackView()
        setHierarchy()
        setLayout()
        setUI()
    }
    
    private func setHierarchy() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(underBar)
        contentView.addSubview(chevronImageView)
    }
    
    private func setLayout() {
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
    }
    
    private func setUI() {
        profileImageView.layer.cornerRadius = 40
        
        nicknameLabel.font = .systemFont(ofSize: 17, weight: .heavy)
        
        registerDateLabel.font = .systemFont(ofSize: 15)
        registerDateLabel.textColor = .grayColor
        
        chevronImageView.image = .chevronRight
        chevronImageView.contentMode = .scaleAspectFit
        chevronImageView.tintColor = .grayColor
        
        underBar.backgroundColor = .darkGrayColor
    }
    
    private func setStackView() {
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        stackView.addArrangedSubview(nicknameLabel)
        stackView.addArrangedSubview(registerDateLabel)
    }
}