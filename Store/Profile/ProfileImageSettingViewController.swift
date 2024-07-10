//
//  ProfileImageSettingViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

final class ProfileImageSettingViewController: BaseTopBarViewController {
    
    let profileViewModel = ProfileViewModel()
    
    private let selectedImageView = CircleImageView(image: UIImage(), type: .profile)
    private let cameraImage = CameraImageView()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var sendProfile: ((Int) -> Void)?
    
    let mode: ProfileSettingMode
    var profileIndex: Int
    
    init(mode: ProfileSettingMode, profileIndex: Int) {
        self.mode = mode
        self.profileIndex = profileIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        navigationItem.title = mode == .newProfile ? "PROFILE SETTING" : "EDIT PROFILE"
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedImageView.image = UIImage(named: "profile_\(profileIndex)")
        collectionView.selectItem(at: IndexPath(item: profileIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        sendProfile?(profileIndex)
    }
    
    private func bindData() {
        profileViewModel.outputProfileName.bind { value in
            self.selectedImageView.image = UIImage(named: value)
        }
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
        profileViewModel.profileList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.id, for: indexPath) as! ProfileCollectionViewCell
        cell.imageView.image = UIImage(named: profileViewModel.profileList[indexPath.item])
        cell.imageView.layer.cornerRadius = cell.frame.width/2
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profile = profileViewModel.profileList[indexPath.item]
        selectedImageView.image = UIImage(named: profile)
        profileIndex = indexPath.item
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
