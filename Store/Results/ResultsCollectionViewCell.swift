//
//  ResultsCollectionViewCell.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import UIKit
import SnapKit
import Kingfisher

final class ResultsCollectionViewCell: BaseCollectionViewCell {
    
    let ud = UserDefaultsHelper.shared
    let repository = StoreRepository()
    
    private let imageView = UIImageView()
    private let likeButton = UIButton()
    private let mallLabel = UILabel()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    
    var item: SearchedItem? {
        didSet {
            setData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
    }
    
    override func setHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(mallLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    override func setLayout() {
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
    
    override func setUI() {
        guard let item else { return }
        let like = ud.likeThisProduct(item.productId)
        imageView.contentMode = .scaleAspectFit
        
        likeButton.setImage(like ? .like : .unlike, for: .normal)
        likeButton.backgroundColor = like ? .whiteColor : .grayColor.withAlphaComponent(0.7)
        likeButton.layer.cornerRadius = 10
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchUpInside)
        
        mallLabel.font = .systemFont(ofSize: 13)
        mallLabel.textColor = .grayColor
        
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
        titleLabel.text = item.title.deleteHtmlTags()
        priceLabel.text = (Int(item.lprice)?.formatted() ?? "1,000") + "원"
        
        likeButton.setImage(like ? .like : .unlike, for: .normal)
        likeButton.backgroundColor = like ? .whiteColor : .grayColor.withAlphaComponent(0.7)
    }
    
    @objc func likeButtonClicked() {
        guard let productId = item?.productId else { return }
        let like = ud.likeThisProduct(productId)
        likeButton.setImage(like ? .unlike : .like, for: .normal)
        likeButton.backgroundColor = like ? .grayColor.withAlphaComponent(0.7) : .whiteColor
        ud.handleLikes(productID: productId)
        
        if let item {
            repository.likeClicked(item: item)
        }
    }
    
}

