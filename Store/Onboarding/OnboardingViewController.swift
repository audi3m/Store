//
//  OnboardingViewController.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {

    let startButton = OrangeButton(title: "시작하기")
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteColor
        
        view.addSubview(startButton)
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
        
        startButton.layer.cornerRadius = 25
        
        imageView.image = .launch
        imageView.contentMode = .scaleAspectFit
        

    }
    

    
    
}
