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
}
