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
    
    let webView = WKWebView()
    let loading = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor 
        
        let like = UIBarButtonItem(image: .likeUnselected, style: .plain, target: self, action: #selector(likeButtonClicked))
        navigationItem.rightBarButtonItem = like
        
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        view.addSubview(loading)
        
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        loading.snp.makeConstraints { make in
            make.center.equalTo(view.center)
        }
        
        loading.style = .large
        loading.hidesWhenStopped = true
        
        
    }
    
    @objc private func likeButtonClicked() {
        
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
