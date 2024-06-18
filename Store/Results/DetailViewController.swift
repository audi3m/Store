//
//  DetailViewController.swift
//  Store
//
//  Created by J Oh on 6/16/24.
//

import UIKit
import SnapKit
import WebKit

class DetailViewController: UIViewController {
    let ud = UserDefaultsHelper.shared
    
    let webView = WKWebView()
    let loading = UIActivityIndicatorView()
    
    var item: SearchItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor 
        
        if let item {
            let like = ud.like(item.productId)
            let likeButton = UIBarButtonItem(image: like ? .like : .unlike,
                                             style: .plain, target: self, action: #selector(likeButtonClicked))
            navigationItem.rightBarButtonItem = likeButton
        }
        
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        view.addSubview(loading)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        loading.snp.makeConstraints { make in
            make.center.equalTo(view.center)
        }
        
        loading.style = .medium
        loading.hidesWhenStopped = true
        
    }
    
    @objc private func likeButtonClicked() {
        guard let productId = item?.productId else { return }
        let image: UIImage = ud.like(productId) ? .unlike : .like
        ud.handleLikes(productID: productId)
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
