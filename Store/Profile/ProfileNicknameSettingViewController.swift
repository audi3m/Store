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

class ProfileNicknameSettingViewController: BaseTopBarViewController {
    
    let ud = UserDefaultsHelper.shared
    
    var profileImageView = CircleImageView(image: UIImage(), type: .profile)
    let cameraImageView = CameraImageView()
    let nicknameTextField = UnderBarTextField()
    let warningLabel = UILabel()
    let completeButton = OrangeButton(title: "완료")
    var goBack = true
    var currentProfile = ""
    
    var warningText = [String]() {
        didSet {
            var text = ""
            for item in warningText {
                if text.isEmpty {
                    text += item
                } else {
                    text += "\n\(item)"
                }
            }
            warningLabel.text = text
        }
    }
    
    let mode: ProfileSettingMode
    let randomProfile = "profile_\(Int.random(in: 0..<12))"
    
    var buttonEnabled = false {
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
            if let profile = ud.profile {
                currentProfile = profile
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let profile = ud.profile {
            profileImageView.image = UIImage(named: profile)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if mode == .newProfile && goBack {
            ud.resetData()
        }
        
        if mode == .edit && goBack {
            ud.profile = currentProfile
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
        goBack = false
        let nickname = nicknameTextField.text!
        ud.nickname = nickname
        ud.registerDate = Date.now.customFormat()
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = SearchViewController()
        let nav = UINavigationController(rootViewController: vc)
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
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
        guard let text = textField.text else { return }
        do {
            try isValidateInput(text: text)
            warningLabel.text = "사용할 수 있는 닉네임이에요"
            buttonEnabled = true
            return
        } catch NicknameValidationError.lengthError {
            warningLabel.text = "2글자 이상 10글자 미만 입력해주세요"
        } catch NicknameValidationError.symbolError {
            warningLabel.text = "@, #, $, %는 포함할 수 없습니다"
        } catch NicknameValidationError.numError {
            warningLabel.text = "숫자는 포함할 수 없습니다"
        } catch {
            fatalError()
        }
        
        buttonEnabled = false
        
    }
    
    @discardableResult
    func isValidateInput(text: String) throws -> Bool {
        guard text.count >= 2 && text.count < 10 else { throw NicknameValidationError.lengthError }
        guard text.rangeOfCharacter(from: CharacterSet(charactersIn: "@#$%")) == nil else { throw NicknameValidationError.symbolError }
        guard text.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789")) == nil else { throw NicknameValidationError.numError }
        return true
    }
}

enum NicknameValidationError: Error {
    case lengthError
    case symbolError
    case numError
}
