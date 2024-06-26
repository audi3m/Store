//
//  ProfileImageSettingViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

final class ProfileImageSettingViewController: BaseTopBarViewController {
    
    private let selectedImageView = CircleImageView(image: UIImage(), type: .profile)
    private let cameraImage = CameraImageView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let profileList = ["profile_0", "profile_1", "profile_2", "profile_3",
                       "profile_4", "profile_5", "profile_6", "profile_7",
                       "profile_8", "profile_9", "profile_10", "profile_11"]
    
    let mode: ProfileSettingMode
    var randomrofile: String?
    
    init(mode: ProfileSettingMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if mode == .newProfile {
            if let randomrofile, let item = profileList.firstIndex(of: randomrofile) {
                selectedImageView.image = UIImage(named: randomrofile)
                collectionView.selectItem(at: IndexPath(item: item, section: 0), animated: true, scrollPosition: .centeredVertically)
            }
        } else {
            if let profile = ud.profile, let item = profileList.firstIndex(of: profile) {
                selectedImageView.image = UIImage(named: profile)
                collectionView.selectItem(at: IndexPath(item: item, section: 0), animated: true, scrollPosition: .centeredVertically)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        navigationItem.title = mode == .newProfile ? "PROFILE SETTING" : "EDIT PROFILE"
    }
    
    override func setHierarchy() {
        view.addSubview(selectedImageView)
        view.addSubview(cameraImage)
        view.addSubview(collectionView)
    }
    
    override func setLayout() {
        
        selectedImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.size.equalTo(120)
        }
        
        cameraImage.snp.makeConstraints { make in
            make.centerX.equalTo(selectedImageView.snp.centerX).offset(42)
            make.centerY.equalTo(selectedImageView.snp.centerY).offset(42)
            make.size.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(selectedImageView.snp.bottom).offset(50)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setUI() {
        setScrollViewProtocols(collectionView, viewController: self)
        collectionView.register(ProfileCollectionViewCell.self, forCellWithReuseIdentifier: ProfileCollectionViewCell.id)
        
        selectedImageView.layer.cornerRadius = 60
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
    
    static private func collectionViewLayout() -> UICollectionViewLayout {
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
