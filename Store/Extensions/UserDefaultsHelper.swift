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
    
    var nickname: String? {
        get {
            return UserDefaults.standard.string(forKey: "nickname")
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
    
    var likeItems: [String: Any] {
        get {
            UserDefaults.standard.dictionary(forKey: "likeItems") ?? [:]
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "likeItems")
        }
    }
    
}

extension UserDefaultsHelper {
    
    
    func deleteSearchQuery(query: String) {
        recentSearch.removeAll { $0 == query }
    }
    
    func handleSearch(query: String) -> [String] {
        if let index = recentSearch.firstIndex(of: query) {
            recentSearch.remove(at: index)
        }
        recentSearch.append(query)
        return recentSearch
    }
    
    func like(_ productID: String) -> Bool {
        likeItems.keys.contains(productID)
    }
    
    func handleLikes(productID: String) {
        if like(productID) {
            likeItems.removeValue(forKey: productID)
        } else {
            likeItems.updateValue(0, forKey: productID)
        }
    }
    
    func resetData() {
        nickname = nil
        registerDate = ""
        profile = nil
        recentSearch = []
        likeItems = [:]
    }
    
}
