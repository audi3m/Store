//
//  RecentListViewController.swift
//  Store
//
//  Created by J Oh on 6/15/24.
//

import UIKit
import SnapKit

class RecentListViewController: UIViewController {
    
    let recentSearchLabel = UILabel()
    let deleteAllButton = UIButton()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setHierarchy()
        setLayout()
        setUI()
        
    }
    
    func setHierarchy() {
        view.addSubview(recentSearchLabel)
        view.addSubview(deleteAllButton)
        view.addSubview(tableView)
    }
    
    func setLayout() {
        recentSearchLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearchLabel.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecentListTableViewCell.self, forCellReuseIdentifier: RecentListTableViewCell.id)
        
        tableView.separatorStyle = .none
        
        recentSearchLabel.text = "최근 검색"
        recentSearchLabel.font = .systemFont(ofSize: 15, weight: .black)
        
        deleteAllButton.setTitle("전체 삭제", for: .normal)
        deleteAllButton.setTitleColor(.themeColor, for: .normal)
        deleteAllButton.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
}

extension RecentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentListTableViewCell.id, for: indexPath) as! RecentListTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    
}
