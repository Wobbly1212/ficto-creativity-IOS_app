//
//  UserSettings.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation

/// Model to manage user settings and preferences.
struct UserSettings: Codable {
    var isDarkModeEnabled: Bool = false
    var notificationsEnabled: Bool = true
    var aiFeedbackEnabled: Bool = true
    var selectedLanguage: String = "en"

    /// Provides default settings if none are found.
    static func defaultSettings() -> UserSettings {
        return UserSettings()
    }
}
