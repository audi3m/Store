//
//  TestViewController.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    let backgroundView = UIView()
    let imageView = UIImageView()
    let camera = CameraImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        view.addSubview(camera)
        
        backgroundView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.size.equalTo(30)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalTo(backgroundView.snp.center)
            make.size.equalTo(20)
        }
        
        camera.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
        }
        
        backgroundView.backgroundColor = .themeColor
        backgroundView.layer.cornerRadius = 15
        
        imageView.image = .camera
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        
    }
    

    

}
