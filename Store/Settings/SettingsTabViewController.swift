//
//  SettingsTabViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit

class SettingsTabViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "SETTING"
        
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.id)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.id)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }

    
    
    
}

extension SettingsTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SettingsItem.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let accountCell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.id, for: indexPath) as! AccountTableViewCell
            
            return accountCell
            
        } else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.id, for: indexPath) as! SettingsTableViewCell
            let title = SettingsItem.allCases[indexPath.row].rawValue
            cell.titleLabel.text = title
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            presentProfileSetting()
        case 5:
            deleteAccountButtonClicked()
        default:
            break
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 120 : 44
    }
    
    private func presentProfileSetting() {
        let vc = ProfileNicknameSettingViewController(mode: .edit)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func deleteAccountButtonClicked() {
        let alert = UIAlertController(title: "탈퇴하기", message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?",
                                      preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let confirm = UIAlertAction(title: "확인", style: .default) { _ in
            self.confirmButtonClicked()
        }
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        present(alert, animated: true)
        
    }
    
    private func confirmButtonClicked() {
        
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
