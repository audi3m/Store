//
//  SettingsTabViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit

class SettingsViewController: BaseViewController {
    
    let ud = UserDefaultsHelper.shared
    let topBar = UIView()
    let tableView = UITableView()
    
    override func viewIsAppearing(_ animated: Bool) {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SETTING"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.id)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.id)
        tableView.separatorColor = .grayColor
         
    }
    
    override func setHierarchy() {
        view.addSubview(topBar)
        view.addSubview(tableView)
    }
     
    override func setLayout() {
        topBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setUI() {
        topBar.backgroundColor = .lightGrayColor
    }
     
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let accountCell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.id, for: indexPath) as! AccountTableViewCell
            accountCell.nicknameLabel.text = ud.nickname
            accountCell.profileImageView.image = UIImage(named: ud.profile ?? "profile_0")
            accountCell.registerDateLabel.text = ud.registerDate
            return accountCell
            
        } else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath) as! SettingsTableViewCell
            let title = SettingsItem.allCases[indexPath.row].rawValue
            if indexPath.row == 1 {
                cell.countLabel.isHidden = false
                cell.countLabel.attributedText = likesCountLabel(count: ud.likeItems.count)
            } else {
                cell.countLabel.isHidden = true
            }
            cell.titleLabel.text = title
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: 
            presentProfileSetting()
        case 5:
            showAlert(type: .resign) {
                self.confirmButtonClicked()
            }
        default: break
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 120 : 44
    }
}

extension SettingsViewController {
    
    private func likesCountLabel(count: Int) -> NSMutableAttributedString {
        let boldAttribute = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)
        ]
        let regularAttribute = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)
        ]
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = .likeSelected
        imageAttachment.bounds = CGRect(x: 0, y: -4, width: 20, height: 20)
        
        let imageAttributedString = NSAttributedString(attachment: imageAttachment)
        
        let boldText = NSAttributedString(string: "\(count)개", attributes: boldAttribute)
        let regularText = NSAttributedString(string: "의 상품", attributes: regularAttribute)
        let newString = NSMutableAttributedString()
        
        newString.append(imageAttributedString)
        newString.append(boldText)
        newString.append(regularText)
        
        return newString
    }
    
    private func presentProfileSetting() {
        let vc = ProfileNicknameSettingViewController(mode: .edit)
        navigationController?.pushViewController(vc, animated: true)
    }
    
//    private func deleteAccountButtonClicked() {
//        let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?",
//                                      preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//        let confirm = UIAlertAction(title: "확인", style: .default) { _ in
//            self.confirmButtonClicked()
//        }
//        
//        alert.addAction(cancel)
//        alert.addAction(confirm)
//        present(alert, animated: true)
//    }
    
    private func confirmButtonClicked() {
        ud.resetData()
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let nav = UINavigationController(rootViewController: OnboardingViewController())
        
        sceneDelegate?.window?.rootViewController = nav
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

enum SettingsItem: String, CaseIterable {
    case account = "계정"
    case myList = "나의 장바구니 목록"
    case qna = "자주 묻는 질문"
    case support = "1:1 문의"
    case notification = "알림 설정"
    case deleteAccount = "탈퇴하기"
}
