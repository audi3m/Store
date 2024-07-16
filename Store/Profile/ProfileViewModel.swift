//
//  ProfileViewModel.swift
//  Store
//
//  Created by J Oh on 7/10/24.
//

import Foundation

final class ProfileViewModel {
    
    var inputProfileIndex: Observable<Int> = Observable(.random(in: 0..<12))
    var outputProfileName: Observable<String> = Observable("")
    
    init() {
        print("ProfileViewModel init")
        inputProfileIndex.bind { _ in
            self.returnProfileName()
        }
    }
    
    deinit {
        print("deinit - ProfileViewModel")
    }
    
    private func returnProfileName() {
        outputProfileName.value = "profile_\(inputProfileIndex.value)"
    }
    
}
