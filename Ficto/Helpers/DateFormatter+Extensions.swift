//
//  DateFormatter+Extensions.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation

// MARK: - DateFormatter Extensions
extension DateFormatter {
    
    // MARK: - Standard Formats
    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let relativeDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.doesRelativeDateFormatting = true
        formatter.dateStyle = .medium
        formatter.locale = Locale.current
        return formatter
    }()
    
    // MARK: - Custom Formats
    static let monthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        formatter.locale = Locale.current
        return formatter
    }()
    
    static let dayMonthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        formatter.locale = Locale.current
        return formatter
    }()
}

// MARK: - Date Extension for String Conversion
extension Date {
    func toString(using formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
}

// MARK: - Usage Examples
struct DateFormatterExtensions_Previews {
    static func run() {
        let now = Date()
        print("Full Date:", now.toString(using: .fullDate))
        print("Short Date:", now.toString(using: .shortDate))
        print("Time Only:", now.toString(using: .timeOnly))
        print("Relative Date:", now.toString(using: .relativeDate))
        print("Month & Year:", now.toString(using: .monthYear))
        print("Day, Month & Year:", now.toString(using: .dayMonthYear))
    }
}


