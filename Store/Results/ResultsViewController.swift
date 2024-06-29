//
//  ResultsViewController.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import UIKit
import Alamofire
import SnapKit

class ResultsViewController: BaseTopBarViewController {
    let storeService = StoreService.shared
    
    let resultCountLabel = UILabel()
    let sortButtonsStack = UIStackView()
    let simButton = SortingButton(option: .sim)
    let dateButton = SortingButton(option: .date)
    let ascButton = SortingButton(option: .asc)
    let dscButton = SortingButton(option: .dsc)
    
    var tabBarIsHidden = false
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var sortOption: SortOptions = .sim {
        didSet {
            start = 1
            storeService.requestItems(query: query, start: start, sortOption: sortOption) { response, error in
                guard error == nil else { return }
                guard let response else { return }
                
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
            sortButtonsStack.isHidden = false
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
        sortButtonsStack.isHidden = true
        
        setScrollViewProtocols(collectionView, viewController: self)
        collectionView.register(ResultsCollectionViewCell.self, forCellWithReuseIdentifier: ResultsCollectionViewCell.id)
        
        setButtons()
        
        storeService.request(query: query, start: start, sortOption: sortOption, model: SearchResponse.self) { response, error in
            guard error == nil else { return }
            guard let response else { return }
            self.applyResponse(response: response)
        }
        
        //        storeService.requestItems(query: query, start: start, sortOption: sortOption) { response, error in
        //            guard error == nil else { return }
        //            guard let response else { return }
        //            self.applyResponse(response: response)
        //
        //        }
        
    }
    
    override func setHierarchy() {
        view.addSubview(resultCountLabel)
        view.addSubview(sortButtonsStack)
        view.addSubview(collectionView)
    }
    
    override func setLayout() {
        resultCountLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
        }
        
        sortButtonsStack.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(sortButtonsStack.snp.bottom).offset(12)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setUI() {
        resultCountLabel.text = " "
        resultCountLabel.font = .boldSystemFont(ofSize: 14)
        resultCountLabel.textColor = .themeColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButtons() {
        sortButtonsStack.axis = .horizontal
        sortButtonsStack.spacing = 7
        sortButtonsStack.addArrangedSubview(simButton)
        sortButtonsStack.addArrangedSubview(dateButton)
        sortButtonsStack.addArrangedSubview(ascButton)
        sortButtonsStack.addArrangedSubview(dscButton)
        
        simButton.addTarget(self, action: #selector(simClicked), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateClicked), for: .touchUpInside)
        ascButton.addTarget(self, action: #selector(ascClicked), for: .touchUpInside)
        dscButton.addTarget(self, action: #selector(dscClicked), for: .touchUpInside)
        
        simButton.selected()
        
    }
    
    func buttonSleep() {
        simButton.isEnabled = false
        dateButton.isEnabled = false
        ascButton.isEnabled = false
        dscButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.simButton.isEnabled = true
            self.dateButton.isEnabled = true
            self.ascButton.isEnabled = true
            self.dscButton.isEnabled = true
        }
    }
    
    @objc private func sortButtonClicked() {
        
    }
    
    @objc private func simClicked() {
        if sortOption != .sim {
            sortOption = .sim
            simButton.selected()
            buttonSleep()
        }
    }
    
    @objc private func dateClicked() {
        if sortOption != .date {
            sortOption = .date
            dateButton.selected()
            buttonSleep()
        }
    }
    
    @objc private func ascClicked() {
        if sortOption != .asc {
            sortOption = .asc
            ascButton.selected()
            buttonSleep()
        }
    }
    
    @objc private func dscClicked() {
        if sortOption != .dsc {
            sortOption = .dsc
            dscButton.selected()
            buttonSleep()
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
                    storeService.request(query: query, start: start, sortOption: sortOption, model: SearchResponse.self) { response, error in
                        guard error == nil else { return }
                        guard let response else { return }
                        self.applyResponse(response: response)
                    }
                    
//                    storeService.requestItems(query: query, start: start, sortOption: sortOption) { response, error in
//                        guard error == nil else { return }
//                        guard let response else { return }
//                        self.applyResponse(response: response)
//                    }
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
        vc.navigationItem.title = item.title.deleteHtmlTags()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
