//
//  SearchTabViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import Alamofire
import SnapKit

class SearchTabViewController: UIViewController {
    
    let ud = UserDefaultsHelper.shared
    
    let searchBar = UISearchBar()
    let underBar = UIView()
    let emptyView = EmptySearchViewController()
    let recentSearchLabel = UILabel()
    let deleteAllButton = UIButton()
    
    let tableView = UITableView()
    var list: [String] = [] {
        didSet {
            tableView.reloadData()
            updateViewVisibility()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        list = ud.recentSearch
        
        setHierarchy()
        setLayout()
        setUI()
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RecentListTableViewCell.self, forCellReuseIdentifier: RecentListTableViewCell.id)
        tableView.separatorStyle = .none
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "\(ud.nickname)'s MEANING OUT"
    }
    
    private func setHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(underBar)
        view.addSubview(emptyView.view)
        view.addSubview(recentSearchLabel)
        view.addSubview(deleteAllButton)
        view.addSubview(tableView)
    }
    
    private func setLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        underBar.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(1)
        }
        
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(underBar.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearchLabel.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(15)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyView.view.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
    }
    
    private func setUI() {
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
        
        underBar.backgroundColor = .lightGrayColor
        
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
    
    private func updateViewVisibility() {
        let recentSearchEmpty = list.isEmpty
        emptyView.view.isHidden = !recentSearchEmpty
        recentSearchLabel.isHidden = recentSearchEmpty
        deleteAllButton.isHidden = recentSearchEmpty
        tableView.isHidden = recentSearchEmpty
    }
    
}



extension SearchTabViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text!
        let vc = ResultsViewController(query: query)
        navigationController?.pushViewController(vc, animated: true)
        
        // UserDefaults 저장
        var list = ud.recentSearch
        if let index = list.firstIndex(of: query) {
            list.remove(at: index)
        }
        list.append(query)
        self.list = list
        ud.recentSearch = list
        
    }
    
}

extension SearchTabViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentListTableViewCell.id, for: indexPath) as! RecentListTableViewCell
        let data = list[indexPath.row]
        cell.searchWordLabel.text = data
        
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
