//
//  OnboardingViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    let titleLabel = UILabel()
    let imageView = UIImageView()
    let startButton = OrangeButton(title: "시작하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Onboarding appear")
        view.backgroundColor = .whiteColor
        
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(startButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
        
        titleLabel.text = "MeaningOut"
        titleLabel.font = .systemFont(ofSize: 35, weight: .black)
        titleLabel.textColor = .themeColor
        
        startButton.layer.cornerRadius = 25
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        
        imageView.image = .launch
        imageView.contentMode = .scaleAspectFit

    }
    
    @objc func startButtonClicked() {
        let vc = ProfileNicknameSettingViewController(mode: .newProfile)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
