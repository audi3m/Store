//
//  ViewController+Ex.swift
//  Store
//
//  Created by J Oh on 6/23/24.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    func showAlert(type: AlertType, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let confirm = UIAlertAction(title: type.confirm, style: .default) { _ in
            completionHandler()
        }
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    
    
}

enum AlertType {
    case resign
    
    var title: String {
        switch self {
        case .resign:
            "탈퇴하기"
        }
    }
    
    var message: String {
        switch self {
        case .resign:
            "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"
        }
    }
    
    var confirm: String {
        switch self {
        case .resign:
            "확인"
        }
    }
    
}
