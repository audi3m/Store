//
//  ResultsViewController.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import UIKit
import Alamofire
import SnapKit

class ResultsViewController: UIViewController {
    
    let resultCountLabel = UILabel()
    let sortStack = UIStackView()
    let simButton = SortingButton(option: .sim)
    let dateButton = SortingButton(option: .date)
    let ascButton = SortingButton(option: .asc)
    let dscButton = SortingButton(option: .dsc)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var sortOption: SortOptions = .sim {
        didSet {
            requestItems(query: query)
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
    
    var list: [SearchItem] = [] {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        if selectedCell >= 0 {
            collectionView.reloadItems(at: [IndexPath(item: selectedCell, section: 0)])
            selectedCell = -1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.title = query
        view.backgroundColor = .whiteColor
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.register(ResultsCollectionViewCell.self, forCellWithReuseIdentifier: ResultsCollectionViewCell.id)
        
        setButtons()
        
        view.addSubview(resultCountLabel)
        view.addSubview(sortStack)
        view.addSubview(collectionView)
        
        resultCountLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        sortStack.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sortStack.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        resultCountLabel.font = .boldSystemFont(ofSize: 14)
        resultCountLabel.textColor = .themeColor
        
        requestItems(query: query)
        
    }
    
    func setButtons() {
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
    
    func requestItems(query: String) {
        let url = StoreAPI.url
        let parameters: Parameters = [
            "query": query,
            "start": start,
            "display": 30,
            "sort": sortOption.rawValue
        ]
        
        AF.request(url, parameters: parameters, headers: StoreAPI.header).responseDecodable(of: SearchResponse.self) { response in
            switch response.result {
            case .success(let value):
                print("SUCCESS")
                self.totalItems = value.total
                self.resultCountLabel.text = "\(self.totalItems.formatted())개의 검색 결과"
                if self.start == 1 {
                    self.list = value.items
                } else {
                    self.list.append(contentsOf: value.items)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func simClicked() {
        sortOption = .sim
        simButton.selected()
    }
    
    @objc func dateClicked() {
        sortOption = .date
        dateButton.selected()
    }
    
    @objc func ascClicked() {
        sortOption = .asc
        ascButton.selected()
    }
    
    @objc func dscClicked() {
        sortOption = .dsc
        dscButton.selected()
    }
    
}

extension ResultsViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if item.item == self.list.count - 2 {
                start += 30
                if start <= totalItems {
                    requestItems(query: query)
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
        let item = list[indexPath.item]
        cell.item = item
        
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
    
    private func cellTapped(item: SearchItem) {
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
