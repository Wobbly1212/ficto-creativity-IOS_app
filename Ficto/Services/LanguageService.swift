//
//  LanguageService.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation
import Combine

/// Service to manage language localization for the app.
class LanguageService: ObservableObject {
    static let shared = LanguageService()  // Singleton instance for shared access

    private let languageKey = "selectedLanguage"
    @Published private(set) var currentLanguage: Language = .english  // Default language

    // MARK: - Supported Languages Enum
    enum Language: String, Codable {
        case english = "en"
        case spanish = "es"
        case french = "fr"

        var displayName: String {
            switch self {
            case .english: return "English"
            case .spanish: return "Español"
            case .french: return "Français"
            }
        }
    }

    internal init() {
        loadSelectedLanguage()
    }

    // MARK: - Language Management

    /// Sets a new language for the app and saves it persistently.
    /// - Parameter language: The new language to set.
    func setLanguage(_ language: Language) {
        currentLanguage = language
        saveSelectedLanguage(language)
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
    }

    /// Gets the currently selected language.
    /// - Returns: The current `Language`.
    func getCurrentLanguage() -> Language {
        return currentLanguage
    }

    /// Returns a localized string for a given key based on the selected language.
    /// - Parameter key: Localization key.
    /// - Returns: Localized string.
    func localizedString(forKey key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, comment: "")
    }

    // MARK: - Persistence

    /// Saves the selected language persistently.
    /// - Parameter language: The language to save.
    private func saveSelectedLanguage(_ language: Language) {
        do {
            let data = try JSONEncoder().encode(language)
            UserDefaults.standard.set(data, forKey: languageKey)
        } catch {
            print("❌ Failed to encode language: \(error.localizedDescription)")
        }
    }

    /// Loads the selected language from persistent storage.
    private func loadSelectedLanguage() {
        guard let data = UserDefaults.standard.data(forKey: languageKey) else { return }
        do {
            currentLanguage = try JSONDecoder().decode(Language.self, from: data)
        } catch {
            print("❌ Failed to decode language: \(error.localizedDescription)")
        }
    }
}

// MARK: - Notification Extension
extension Notification.Name {
    static let languageDidChange = Notification.Name("languageDidChange")
}
