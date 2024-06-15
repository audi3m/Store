//
//  Date+Ex.swift
//  Store
//
//  Created by J Oh on 6/14/24.
//

import Foundation

extension Date {
    func customFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd."
        return dateFormatter.string(from: self)
    }
}
