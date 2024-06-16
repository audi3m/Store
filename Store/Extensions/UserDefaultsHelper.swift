//
//  UserDefaultsHelper.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import UIKit


// nickname
// profile
// recentSearch
class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    var nickname: String {
        get {
            return UserDefaults.standard.string(forKey: "nickname") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
    
    var registerDate: String {
        get {
            return UserDefaults.standard.string(forKey: "registerDate") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "registerDate")
        }
    }
    
    var profile: String? {
        get {
            return UserDefaults.standard.string(forKey: "profile")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "profile")
        }
    }
    
    var recentSearch: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: "recentSearch") ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "recentSearch")
        }
    }
    
}
