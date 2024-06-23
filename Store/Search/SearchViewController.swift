//
//  SearchTabViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import Alamofire
import SnapKit

class SearchViewController: UIViewController {
    
    let ud = UserDefaultsHelper.shared
    
    let searchBar = UISearchBar()
    let underBar = UIView()
    let emptyView = EmptySearchViewController()
    let recentSearchLabel = UILabel()
    let deleteAllButton = UIButton()
    
    let recentTableView = UITableView()
    var recentList: [String] = [] {
        didSet {
            recentTableView.reloadData()
            updateViewVisibility()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let settings = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"),style: .plain, target: self,
                                       action: #selector(settingsButtonClicked))
        navigationItem.rightBarButtonItem = settings
        self.hideKeyboardWhenTappedAround()
        
        recentList = ud.recentSearch.reversed()
        
        setHierarchy()
        setLayout()
        setUI()
        
        searchBar.delegate = self
        
        recentTableView.delegate = self
        recentTableView.dataSource = self
        recentTableView.register(RecentListTableViewCell.self, forCellReuseIdentifier: RecentListTableViewCell.id)
        recentTableView.rowHeight = 44
        recentTableView.separatorStyle = .none
        recentTableView.keyboardDismissMode = .onDrag
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "\(ud.nickname ?? "")'s MEANING OUT"
    }
    
    private func setHierarchy() {
        view.addSubview(underBar)
        view.addSubview(searchBar)
        view.addSubview(emptyView.view)
        view.addSubview(recentSearchLabel)
        view.addSubview(deleteAllButton)
        view.addSubview(recentTableView)
    }
    
    private func setLayout() {
        underBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(1)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        recentSearchLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        deleteAllButton.snp.makeConstraints { make in
            make.centerY.equalTo(recentSearchLabel.snp.centerY)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        
        recentTableView.snp.makeConstraints { make in
            make.top.equalTo(recentSearchLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        emptyView.view.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
        }
        
    }
    
    private func setUI() {
        underBar.backgroundColor = .lightGrayColor
        
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
        
        recentSearchLabel.text = "최근 검색"
        recentSearchLabel.font = .systemFont(ofSize: 15, weight: .black)
        
        deleteAllButton.setTitle("전체 삭제", for: .normal)
        deleteAllButton.setTitleColor(.themeColor, for: .normal)
        deleteAllButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        deleteAllButton.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
    }
    
    @objc private func deleteAll() {
        recentList = ud.deleteSearchHistory()
    }
    
    @objc private func settingsButtonClicked() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func updateViewVisibility() {
        let recentSearchEmpty = recentList.isEmpty
        emptyView.view.isHidden = !recentSearchEmpty
        recentSearchLabel.isHidden = recentSearchEmpty
        deleteAllButton.isHidden = recentSearchEmpty
        recentTableView.isHidden = recentSearchEmpty
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = searchBar.text!
        if !query.isEmptyOrWhiteSpace() {
            recentList = ud.handleSearch(query: query).reversed()
            let vc = ResultsViewController(query: query)
            navigationController?.pushViewController(vc, animated: true)
        }
        searchBar.text = ""
        view.endEditing(true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentListTableViewCell.id, for: indexPath) as! RecentListTableViewCell
        let data = recentList[indexPath.row]
        cell.searchWordLabel.text = data
        cell.xButton.tag = indexPath.row
        cell.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let query = recentList[indexPath.row]
        let vc = ResultsViewController(query: query)
        navigationController?.pushViewController(vc, animated: true)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        recentList = ud.handleSearch(query: query).reversed()
    }
    
    @objc private func xButtonClicked(sender: UIButton) {
        let query = recentList[sender.tag]
        ud.deleteSearchQuery(query: query)
        recentList = ud.recentSearch.reversed()
    }
    
}
