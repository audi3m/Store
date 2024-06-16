//
//  ProfileImageSettingViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

class ProfileImageSettingViewController: UIViewController {
    
    let ud = UserDefaultsHelper.shared
    
    lazy var selectedImageView = CircleImageView(image: UIImage(named: ud.profile ?? "profile_\(Int.random(in: 0..<12))")!, type: .profile)
    let cameraImage = CameraImageView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let profileList = ["profile_0", "profile_1", "profile_2", "profile_3",
                       "profile_4", "profile_5", "profile_6", "profile_7",
                       "profile_8", "profile_9", "profile_10", "profile_11"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "PROFILE SETTING"
        
        view.backgroundColor = .whiteColor
        view.addSubview(selectedImageView)
        view.addSubview(cameraImage)
        view.addSubview(collectionView)
        
        selectedImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.size.equalTo(120)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.centerX.equalTo(selectedImageView.snp.centerX).offset(42.43)
            make.centerY.equalTo(selectedImageView.snp.centerY).offset(42.43)
            make.size.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom).offset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.id)
        
        selectedImageView.layer.cornerRadius = 60
        
        if let profile = ud.profile,
           let item = profileList.firstIndex(of: profile) {
            collectionView.selectItem(at: IndexPath(item: item, section: 0), animated: true, scrollPosition: .centeredVertically)
        }
    }
    
}

extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.id, for: indexPath) as! ProfileCollectionViewCell
        cell.imageView.image = UIImage(named: profileList[indexPath.item])
        cell.imageView.layer.cornerRadius = cell.frame.width/2
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profile = profileList[indexPath.item]
        selectedImageView.image = UIImage(named: profile)
        ud.profile = profile
        
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2 + cellSpacing * 3)
        layout.itemSize = CGSize(width: width/4, height: width/4)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
}
