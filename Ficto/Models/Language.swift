//
//  Language.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation

/// Enum to define supported languages.
enum SupportedLanguage: String, Codable {
    case english = "en"
    case spanish = "es"
    case french = "fr"

    /// Returns the display name for each supported language.
    var displayName: String {
        switch self {
        case .english:
            return NSLocalizedString("English", comment: "")
        case .spanish:
            return NSLocalizedString("Spanish", comment: "")
        case .french:
            return NSLocalizedString("French", comment: "")
        }
    }
}

/// Manages language settings and localization.
class LanguageManager: ObservableObject {
    static let shared = LanguageManager()  // Singleton instance

    @Published private(set) var currentLanguage: SupportedLanguage = .english {
        didSet {
            saveLanguageSetting()
        }
    }

    private init() {
        loadLanguageSetting()  // Load saved language preference
    }

    /// Switches the app language.
    func switchLanguage(to language: SupportedLanguage) {
        currentLanguage = language
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
    }

    /// Gets localized string for a given key.
    func localizedString(forKey key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, comment: "")
    }
    func translate(text: String, to language: SupportedLanguage, completion: @escaping (String) -> Void) {
            // Example translation logic
            // You can integrate a translation API here like Google Translate, Microsoft Translator, etc.
            
            // For now, just simulate a translation by appending the language code
            DispatchQueue.global().async {
                let translatedText = "\(text) in \(language.rawValue)"  // Example translation logic
                DispatchQueue.main.async {
                    completion(translatedText)
                }
            }
        }


    /// Saves the current language setting to UserDefaults.
    private func saveLanguageSetting() {
        UserDefaults.standard.set(currentLanguage.rawValue, forKey: "selectedLanguage")
    }

    /// Loads the saved language setting from UserDefaults.
    private func loadLanguageSetting() {
        if let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage"),
           let language = SupportedLanguage(rawValue: savedLanguage) {
            currentLanguage = language
        }
    }
}
