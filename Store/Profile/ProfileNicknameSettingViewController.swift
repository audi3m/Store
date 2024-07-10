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

final class ProfileNicknameSettingViewController: BaseTopBarViewController {
    
    private let nicknameViewModel = NicknameViewModel(nil)
    
    
    private var profileImageView = CircleImageView(image: UIImage(), type: .profile)
    private let cameraImageView = CameraImageView()
    private let nicknameTextField = UnderBarTextField()
    private let warningLabel = UILabel()
    private let completeButton = OrangeButton(title: "완료")
    private var goBack = true
    private var currentProfile = ""
    
    let mode: ProfileSettingMode
    let randomProfileIndex = Int.random(in: 0..<12)
    
    private var buttonEnabled = false {
        didSet {
            completeButton.isEnabled = buttonEnabled
            navigationItem.rightBarButtonItem?.isEnabled = buttonEnabled
        }
    }
    
    init(mode: ProfileSettingMode) {
        self.mode = mode
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()  
        
        setNavBar()
         
        setProfileImageView()
        setNicknameTextField()
        setCompleteButton()
        
        if mode == .edit {
            completeButton.isHidden = true
            warningLabel.text = "사용할 수 있는 닉네임이에요"
            if let profileIndex = ud.profileIndex {
                currentProfile = "profile_\(profileIndex)"
            }
        }
        
        nicknameViewModel.inputNickname.value = ud.nickname
        bindData()
    }
    
    private func bindData() {
        nicknameViewModel.outputValidationText.bind { value in
            self.warningLabel.text = value
        }
        
        nicknameViewModel.outputValid.bind { value in
            self.warningLabel.textColor = value ? .themeColor : .red
            self.navigationItem.rightBarButtonItem?.isEnabled = value
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let profileIndex = ud.profileIndex {
            profileImageView.image = UIImage(named: "profile_\(profileIndex)")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if goBack {
            if mode == .newProfile {
                
            } else {
                ud.profileIndex = currentProfile
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setNavBar() {
        navigationItem.title = mode == .newProfile ? "PROFILE SETTING" : "EDIT PROFILE"
        
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        if mode == .edit {
            navigationItem.rightBarButtonItem = saveButton
        }
    }
    
    override func setHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(cameraImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(warningLabel)
        view.addSubview(completeButton)
    }
    
    override func setLayout() {
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
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
        
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(15)
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
        
        if let profileIndex = ud.profileIndex {
            profileImageView.image = UIImage(named: "profile_\(profileIndex)")
        } else {
            profileImageView.image = UIImage(named: "profile_\(randomProfileIndex)")
        }
    }
    
    private func setNicknameTextField() {
        nicknameTextField.delegate = self
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nicknameTextField.text = ud.nickname
        nicknameTextField.placeholder = "닉네임"
        
        warningLabel.textColor = .themeColor
        warningLabel.font = .systemFont(ofSize: 13)
    }
    
    private func setCompleteButton() {
        completeButton.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
    }
    
    @objc private func selectProfile() {
        let vc = ProfileImageSettingViewController(mode: mode, profileIndex: <#Int#>)
        if let profileIndex = ud.profileIndex {
            vc.profileIndex = profileIndex
        } else {
            vc.profileIndex = randomProfileIndex
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func completeButtonClicked() {
        goBack = false
        let nickname = nicknameTextField.text!
        ud.nickname = nickname
        ud.profileIndex = randomProfile
        ud.registerDate = Date.now.customFormat()
        
        resetRootViewController(root: TabBarController())
        
    }
    
    @objc private func saveButtonClicked() {
        goBack = false
        let nickname = nicknameTextField.text!
        ud.nickname = nickname
        navigationController?.popViewController(animated: true)
    }
    
}

extension ProfileNicknameSettingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        nicknameViewModel.inputNickname.value = nicknameTextField.text
    }
}

enum NicknameValidationError: Error {
    case lengthError
    case symbolError
    case numError
}
