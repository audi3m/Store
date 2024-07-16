//
//  DetailViewController.swift
//  Store
//
//  Created by J Oh on 6/16/24.
//

import UIKit
import SnapKit
import WebKit

final class DetailViewController: BaseViewController {
    
    let repository = ItemRepository()
    
    let webView = WKWebView()
    private let loading = UIActivityIndicatorView()
    
    var item: SearchedItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item {
            let like = UserDefaultsHelper.shared.likeThisProduct(item.productId)
            let likeButton = UIBarButtonItem(image: like ? .like : .unlike,
                                             style: .plain, target: self, action: #selector(likeButtonClicked))
            navigationItem.rightBarButtonItem = likeButton
        }
        
    }
    
    override func setHierarchy() {
        view.addSubview(webView)
        view.addSubview(loading)
    }
    
    override func setLayout() {
        
        webView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        loading.snp.makeConstraints { make in
            make.center.equalTo(view.center)
        }
    }
    
    override func setUI() {
        webView.navigationDelegate = self
        loading.style = .medium
        loading.hidesWhenStopped = true
    }
    
    @objc private func likeButtonClicked() {
        guard let productId = item?.productId else { return }
        let image: UIImage = UserDefaultsHelper.shared.likeThisProduct(productId) ? .unlike : .like
        UserDefaultsHelper.shared.handleLikes(productID: productId)
        if let item {
            repository.likeClicked(item: item)
        }
        navigationItem.rightBarButtonItem?.image = image
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loading.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        loading.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        loading.stopAnimating()
    }
}
