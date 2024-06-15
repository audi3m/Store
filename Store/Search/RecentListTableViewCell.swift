//
//  RecentListTableViewCell.swift
//  Store
//
//  Created by J Oh on 6/15/24.
//

import UIKit
import SnapKit

class RecentListTableViewCell: UITableViewCell {
    
    let clockImage = UIImageView()
    let searchWordLabel = UILabel()
    let xButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(clockImage)
        contentView.addSubview(searchWordLabel)
        contentView.addSubview(xButton)
        
        clockImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        searchWordLabel.snp.makeConstraints { make in
            make.leading.equalTo(clockImage.snp.trailing).offset(20)
            make.trailing.lessThanOrEqualTo(xButton.snp.leading).offset(-20)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        xButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.trailing.equalTo(contentView.snp.trailing).offset(-20)
        }
        
        clockImage.image = .clock
        clockImage.contentMode = .scaleAspectFit
        clockImage.tintColor = .blackColor
        
        searchWordLabel.font = .boldSystemFont(ofSize: 14)
        searchWordLabel.text = "맥북 거치대"
        
        xButton.setImage(.xmark, for: .normal)
        xButton.tintColor = .blackColor
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
