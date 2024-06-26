//
//  String+Ex.swift
//  Store
//
//  Created by J Oh on 6/18/24.
//

import Foundation

extension String {
    func isEmptyOrWhiteSpace() -> Bool {
        let trimmed = self.trimmingCharacters(in: .whitespaces)
        return trimmed.isEmpty
    }
    
    func deleteHtmlTags() -> String {
        let regex = try! NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive)
        let range = NSMakeRange(0, self.count)
        let result = regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "")
        return result
    }
}
