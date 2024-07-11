//
//  ProfileViewModel.swift
//  Store
//
//  Created by J Oh on 7/10/24.
//

import Foundation

final class ProfileViewModel {
    
    let profileList = ["profile_0", "profile_1", "profile_2", "profile_3",
                       "profile_4", "profile_5", "profile_6", "profile_7",
                       "profile_8", "profile_9", "profile_10", "profile_11"]
    
    var inputProfileIndex: Observable<Int> = Observable(.random(in: 0..<12))
    var outputProfileName: Observable<String> = Observable("")
    
    init() {
        print("ProfileViewModel init")
        inputProfileIndex.bind { _ in
            self.returnProfileName()
        }
    }
    
    private func returnProfileName() {
        outputProfileName.value = "profile_\(inputProfileIndex.value)"
        
    }
    
    
}
