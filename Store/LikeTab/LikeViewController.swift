//
//  LikeViewController.swift
//  Store
//
//  Created by J Oh on 7/8/24.
//

import UIKit
import RealmSwift
import SnapKit

final class LikeViewController: BaseTopBarViewController {
    let storeService = StoreService.shared
    let repository = ItemRepository()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var list: Results<StoreModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "좋아요 상품"
        list = repository.fetchAll()
        
        setScrollViewProtocols(collectionView, viewController: self)
        collectionView.register(ResultsCollectionViewCell.self, forCellWithReuseIdentifier: ResultsCollectionViewCell.id)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Like Tab will appear")
        collectionView.reloadData()
    }
    
    override func setHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func setLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func listCount() { }
    
}

extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultsCollectionViewCell.id, for: indexPath) as! ResultsCollectionViewCell
        cell.item = list[indexPath.item].convertToItem()
        cell.updated = { updated in
            if updated {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.list = self.repository.fetchAll()
                    collectionView.reloadData()
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = list[indexPath.item]
        let item = model.convertToItem()
        cellTapped(item: item)
    }
    
    static private func collectionViewLayout() -> UICollectionViewLayout {
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

