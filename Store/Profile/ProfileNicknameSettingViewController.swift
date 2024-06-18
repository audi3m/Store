//
//  ProfileNicknameSettingViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

enum ProfileSettingMode {
    case newProfile
    case edit
}

class ProfileNicknameSettingViewController: UIViewController {
    
    let ud = UserDefaultsHelper.shared
    
    let topBar = UIView()
    var profileImageView = CircleImageView(image: UIImage(), type: .profile)
    let cameraImageView = CameraImageView()
    let nicknameTextField = UITextField()
    let underBar = UIView()
    let warningLabel = UILabel()
    let completeButton = OrangeButton(title: "완료")
    
    let mode: ProfileSettingMode
    let randomProfile = "profile_\(Int.random(in: 0..<12))"
    
    var buttonEnabled = false {
        didSet {
            completeButton.isEnabled = buttonEnabled
        }
    }
    
    init(mode: ProfileSettingMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let profile = ud.profile {
            profileImageView.image = UIImage(named: profile)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        setNavBar()
        
        setHierarchy()
        setLayout()
        
        setProfileImageView()
        setNicknameTextField()
        setCompleteButton()
        
        if mode == .edit {
            completeButton.isHidden = true
            warningLabel.text = "사용할 수 있는 닉네임이에요"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavBar() {
        navigationItem.title = mode == .newProfile ? "PROFILE SETTING" : "EDIT PROFILE"
        topBar.backgroundColor = .lightGrayColor
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .black),
            .foregroundColor: UIColor.black
        ]
        
        saveButton.setTitleTextAttributes(attributes, for: .normal)
        
        if mode == .edit {
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    private func setHierarchy() {
        view.addSubview(topBar)
        view.addSubview(profileImageView)
        view.addSubview(cameraImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(underBar)
        view.addSubview(warningLabel)
        view.addSubview(completeButton)
    }
    
    private func setLayout() {
        topBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(topBar.snp.bottom).offset(40)
            make.size.equalTo(120)
        }
        
        cameraImageView.snp.makeConstraints { make in
            make.centerX.equalTo(profileImageView.snp.centerX).offset(41)
            make.centerY.equalTo(profileImageView.snp.centerY).offset(41)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
        
        underBar.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(1)
        }
        
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(underBar.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(24)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(warningLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }
    
    private func setProfileImageView() {
        profileImageView.layer.cornerRadius = 60
        profileImageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectProfile))
        profileImageView.addGestureRecognizer(gesture)
        
        if let profile = ud.profile {
            profileImageView.image = UIImage(named: profile)
        } else {
            profileImageView.image = UIImage(named: randomProfile)
        }
    }
    
    private func setNicknameTextField() {
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nicknameTextField.text = ud.nickname
        nicknameTextField.placeholder = "닉네임"
        
        underBar.backgroundColor = .lightGrayColor
        
        warningLabel.textColor = .themeColor
        warningLabel.font = .systemFont(ofSize: 13)
    }
    
    private func setCompleteButton() {
        completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
    @objc private func selectProfile() {
        let vc = ProfileImageSettingViewController(mode: mode)
        if let profile = ud.profile {
            vc.randomrofile = profile
        } else {
            vc.randomrofile = randomProfile
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func completeButtonClicked() {
        let nickname = nicknameTextField.text!
        ud.nickname = nickname
        ud.registerDate = Date.now.customFormat()
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = TabBarController()
        
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc private func saveButtonClicked() {
        print("Save!")
        let nickname = nicknameTextField.text!
        ud.nickname = nickname
        navigationController?.popViewController(animated: true)
    }
}

extension ProfileNicknameSettingViewController: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count < 2 || text.count >= 10 {
            warningLabel.text = "2글자 이상 10글자 미만"
            buttonEnabled = false
        } else if text.rangeOfCharacter(from: CharacterSet(charactersIn: "@#$%")) != nil {
            warningLabel.text = "@, #, $, %는 포함할 수 없습니다"
            buttonEnabled = false
        } else if text.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) != nil {
            warningLabel.text = "숫자는 포함할 수 없습니다"
            buttonEnabled = false
        } else {
            warningLabel.text = "사용할 수 있는 닉네임이에요"
            buttonEnabled = true
        }
    }
}
