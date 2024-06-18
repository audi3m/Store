//
//  ResultsCollectionViewCell.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import UIKit
import SnapKit
import Kingfisher

class ResultsCollectionViewCell: UICollectionViewCell {
    
    let ud = UserDefaultsHelper.shared
    
    let imageView = UIImageView()
    let likeButton = UIButton()
    let mallLabel = UILabel()
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    
    var item: SearchItem? {
        didSet {
            setData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setHierarchy()
        setLayout()
    }
    
    private func setHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(mallLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    private func setLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView)
            make.height.equalTo(contentView.snp.width).multipliedBy(1.2)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(imageView).inset(12)
            make.size.equalTo(35)
        }
        
        mallLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalTo(contentView)
        }
        
    }
    
    private func setUI() {
        guard let item else { return }
        let like = ud.like(item.productId)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .lightGrayColor
        
        likeButton.setImage(like ? .like : .unlike, for: .normal)
        likeButton.backgroundColor = like ? .whiteColor : .grayColor.withAlphaComponent(0.7)
        likeButton.layer.cornerRadius = 10
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        mallLabel.font = .systemFont(ofSize: 13)
        mallLabel.textColor = .lightGrayColor
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 2
        
        priceLabel.font = .systemFont(ofSize: 15, weight: .black)
        
    }
    
    private func setData() {
        guard let item else { return }
        let like = ud.likeItems.keys.contains(item.productId)
        let url = URL(string: item.image)
        imageView.kf.setImage(with: url)
        
        likeButton.setImage(.likeUnselected, for: .normal)
        mallLabel.text = item.mallName
        titleLabel.text = item.title
        priceLabel.text = (Int(item.lprice)?.formatted() ?? "1,000") + "원"
        
        likeButton.setImage(like ? .like : .unlike, for: .normal)
        likeButton.backgroundColor = like ? .whiteColor : .grayColor.withAlphaComponent(0.7)
        
    }
    
    @objc func likeButtonClicked() {
        guard let productId = item?.productId else { return }
        let like = ud.like(productId)
        likeButton.setImage(like ? .unlike : .like, for: .normal)
        likeButton.backgroundColor = like ? .grayColor.withAlphaComponent(0.7) : .whiteColor
        ud.handleLikes(productID: productId)
    }
    
}

