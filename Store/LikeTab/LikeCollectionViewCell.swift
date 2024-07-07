////
////  LikeCollectionViewCell.swift
////  Store
////
////  Created by J Oh on 7/8/24.
////
//
//import UIKit
//
//final class LikeCollectionViewCell: BaseCollectionViewCell {
//    
//    let ud = UserDefaultsHelper.shared
//    
//    private let imageView = UIImageView()
//    private let likeButton = UIButton()
//    private let mallLabel = UILabel()
//    private let titleLabel = UILabel()
//    private let priceLabel = UILabel()
//    
//    var item: SearchedItem? {
//        didSet {
//            setData()
//        }
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        setUI()
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        
//    }
//    
//    override func setHierarchy() {
//        contentView.addSubview(imageView)
//        contentView.addSubview(likeButton)
//        contentView.addSubview(mallLabel)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(priceLabel)
//    }
//    
//    override func setLayout() {
//        imageView.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalTo(contentView)
//            make.height.equalTo(contentView.snp.width).multipliedBy(1.2)
//        }
//        
//        likeButton.snp.makeConstraints { make in
//            make.trailing.bottom.equalTo(imageView).inset(12)
//            make.size.equalTo(35)
//        }
//        
//        mallLabel.snp.makeConstraints { make in
//            make.top.equalTo(imageView.snp.bottom).offset(5)
//            make.horizontalEdges.equalTo(contentView)
//        }
//        
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalTo(mallLabel.snp.bottom).offset(5)
//            make.horizontalEdges.equalTo(contentView)
//        }
//        
//        priceLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(5)
//            make.horizontalEdges.equalTo(contentView)
//        }
//    }
//    
//    override func setUI() {
//        guard let item else { return }
//        imageView.contentMode = .scaleAspectFit
//        
//        
//        mallLabel.font = .systemFont(ofSize: 13)
//        mallLabel.textColor = .grayColor
//        
//        titleLabel.font = .systemFont(ofSize: 14)
//        titleLabel.numberOfLines = 2
//        
//        priceLabel.font = .systemFont(ofSize: 15, weight: .black)
//    }
//    
//    private func setData() {
//        guard let item else { return }
//        let like = ud.likeItems.keys.contains(item.productId)
//        let url = URL(string: item.image)
//        imageView.kf.setImage(with: url)
//        
//        likeButton.setImage(.likeUnselected, for: .normal)
//        mallLabel.text = item.mallName
//        titleLabel.text = item.title.deleteHtmlTags()
//        priceLabel.text = (Int(item.lprice)?.formatted() ?? "1,000") + "원"
//        
//        likeButton.setImage(like ? .like : .unlike, for: .normal)
//        likeButton.backgroundColor = like ? .whiteColor : .grayColor.withAlphaComponent(0.7)
//    }
//    
//    
//    
//}
//
//
