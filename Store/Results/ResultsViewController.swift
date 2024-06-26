//
//  ResultsViewController.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import UIKit
import Alamofire
import SnapKit

class ResultsViewController: BaseViewController {
    let storeService = StoreService.shared
    
    let topBar = UIView()
    let resultCountLabel = UILabel()
    let sortStack = UIStackView()
    let simButton = SortingButton(option: .sim)
    let dateButton = SortingButton(option: .date)
    let ascButton = SortingButton(option: .asc)
    let dscButton = SortingButton(option: .dsc)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var sortOption: SortOptions = .sim {
        didSet {
            start = 1
            storeService.requestItems(query: query, start: start, sortOption: sortOption) { response in
                self.applyResponse(response: response)
            }
            simButton.deSelected()
            dateButton.deSelected()
            ascButton.deSelected()
            dscButton.deSelected()
        }
    }
    let query: String
    var start = 1
    var totalItems = 0
    var selectedCell = -1
    
    var list: [SearchedItem] = [] {
        didSet {
            collectionView.reloadData()
            if start == 1 && !list.isEmpty {
                collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    init(query: String) {
        self.query = query
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        if selectedCell >= 0 {
            collectionView.reloadItems(at: [IndexPath(item: selectedCell, section: 0)])
            selectedCell = -1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = query 
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(ResultsCollectionViewCell.self, forCellWithReuseIdentifier: ResultsCollectionViewCell.id)
        
        setButtons()
         
        storeService.requestItems(query: query, start: start, sortOption: sortOption) { response in
            self.applyResponse(response: response)
        }
        
    }
    
    override func setHierarchy() {
        view.addSubview(topBar)
        view.addSubview(resultCountLabel)
        view.addSubview(sortStack)
        view.addSubview(collectionView)
    }
    
    override func setLayout() {
        topBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        resultCountLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        sortStack.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(15)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sortStack.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setUI() {
        topBar.backgroundColor = .lightGrayColor
        resultCountLabel.text = " "
        resultCountLabel.font = .boldSystemFont(ofSize: 14)
        resultCountLabel.textColor = .themeColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtons() {
        sortStack.axis = .horizontal
        sortStack.spacing = 7
        sortStack.addArrangedSubview(simButton)
        sortStack.addArrangedSubview(dateButton)
        sortStack.addArrangedSubview(ascButton)
        sortStack.addArrangedSubview(dscButton)
        
        simButton.addTarget(self, action: #selector(simClicked), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateClicked), for: .touchUpInside)
        ascButton.addTarget(self, action: #selector(ascClicked), for: .touchUpInside)
        dscButton.addTarget(self, action: #selector(dscClicked), for: .touchUpInside)
        
        simButton.selected()
        
    }
    
    @objc private func simClicked() {
        if sortOption != .sim {
            sortOption = .sim
            simButton.selected()
        }
    }
    
    @objc private func dateClicked() {
        if sortOption != .date {
            sortOption = .date
            dateButton.selected()
        }
    }
    
    @objc private func ascClicked() {
        if sortOption != .asc {
            sortOption = .asc
            ascButton.selected()
        }
    }
    
    @objc private func dscClicked() {
        if sortOption != .dsc {
            sortOption = .dsc
            dscButton.selected()
        }
    }
    
    func applyResponse(response: SearchResponse) {
        self.totalItems = response.total
        self.resultCountLabel.text = "\(self.totalItems.formatted())개의 검색 결과"
        if self.start == 1 {
            self.list = response.items
        } else {
            self.list.append(contentsOf: response.items)
        }
    }
}

extension ResultsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if item.item == self.list.count - 2 {
                start += 30
                if start <= totalItems {
                    storeService.requestItems(query: query, start: start, sortOption: sortOption) { response in
                        self.applyResponse(response: response)
                    }
                }
            }
        }
    }
}

extension ResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCollectionViewCell.id, for: indexPath) as! ResultsCollectionViewCell
        cell.item = list[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = list[indexPath.item]
        cellTapped(item: item)
        selectedCell = indexPath.item
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 20
        let cellSpacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2 + cellSpacing)
        layout.itemSize = CGSize(width: width/2, height: width/1.2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    private func cellTapped(item: SearchedItem) {
        let vc = DetailViewController()
        if let url = URL(string: item.link) {
            let request = URLRequest(url: url)
            vc.webView.load(request)
        }
        vc.item = item
        vc.navigationItem.title = item.title
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
