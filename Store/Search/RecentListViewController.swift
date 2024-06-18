//
//  RecentListViewController.swift
//  Store
//
//  Created by J Oh on 6/15/24.
//

import UIKit
import SnapKit

class RecentListViewController: UIViewController {
    
    let ud = UserDefaultsHelper.shared
    
    let recentSearchLabel = UILabel()
    let deleteAllButton = UIButton()
    let tableView = UITableView()
    var list: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = ud.recentSearch
        
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
        deleteAllButton.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
    }
    
    @objc func deleteAll() {
        ud.recentSearch = []
        list = []
    }
    
}

extension RecentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentListTableViewCell.id, for: indexPath) as! RecentListTableViewCell
        let query = list[indexPath.row]
        
        cell.searchWordLabel.text = query
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = list[indexPath.row]
        let vc = ResultsViewController(query: query)
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
