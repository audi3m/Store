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
final class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    private init() { }
    
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
    
    var profileIndex: Int? {
        get {
            return UserDefaults.standard.integer(forKey: "profile")
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
    
    func resetData() {
        nickname = nil
        registerDate = ""
        profileIndex = nil
        recentSearch = []
        likeItems = [:]
    }
}

// search functions
extension UserDefaultsHelper {
    
    func deleteSearchQuery(query: String) {
        recentSearch.removeAll { $0 == query }
    }
    
    @discardableResult
    func handleSearch(query: String) -> [String] {
        if let index = recentSearch.firstIndex(of: query) {
            recentSearch.remove(at: index)
        }
        recentSearch.append(query)
        return recentSearch
    }
    
    @discardableResult
    func deleteSearchHistory() -> [String] {
        recentSearch.removeAll()
        return []
    }
    
}

// like funtions
extension UserDefaultsHelper {
    func likeThisProduct(_ productID: String) -> Bool {
        likeItems.keys.contains(productID)
    }
    
    func handleLikes(productID: String) {
        if likeThisProduct(productID) {
            likeItems.removeValue(forKey: productID)
        } else {
            likeItems.updateValue(0, forKey: productID)
        }
    }
}
