//
//  RecentListTableViewCell.swift
//  Store
//
//  Created by J Oh on 6/15/24.
//

import UIKit
import SnapKit

final class RecentListTableViewCell: BaseTableViewCell {
    let ud = UserDefaultsHelper.shared
    
    let clockImage = UIImageView()
    let searchWordLabel = UILabel()
    let xButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         
    }
    
    override func setHierarchy() {
        contentView.addSubview(clockImage)
        contentView.addSubview(searchWordLabel)
        contentView.addSubview(xButton)
    }
    
    override func setLayout() {
        clockImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        xButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView).offset(-20)
        }
        
        searchWordLabel.snp.makeConstraints { make in
            make.leading.equalTo(clockImage.snp.trailing).offset(20)
            make.width.equalTo(contentView.snp.width).offset(-120)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    override func setUI() {
        clockImage.image = .clock
        clockImage.contentMode = .scaleAspectFit
        clockImage.tintColor = .blackColor
        
        searchWordLabel.font = .boldSystemFont(ofSize: 14)
        
        xButton.setImage(.xmark, for: .normal)
        xButton.tintColor = .blackColor
    } 
    
}
