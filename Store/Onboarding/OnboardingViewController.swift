//
//  OnboardingViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

class OnboardingViewController: BaseViewController {
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let startButton = OrangeButton(title: "시작하기")
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    override func setHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(startButton)
    }
    
    override func setLayout() {
        imageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.size.equalTo(view.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(imageView.snp.top).offset(-30)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }
    
    override func setUI() {
        titleLabel.text = "MeaningOut"
        titleLabel.font = .systemFont(ofSize: 40, weight: .black)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .themeColor
        
        startButton.layer.cornerRadius = 25
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        imageView.image = .launch
        imageView.contentMode = .scaleAspectFit
    }
    
    @objc private func startButtonClicked() {
        let vc = ProfileNicknameSettingViewController(mode: .newProfile)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
