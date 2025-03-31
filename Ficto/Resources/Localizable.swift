//
//  Localizable.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation


// MARK: - Localizable Keys
enum LocalizableKey: String {
    // General
    case appName = "app_name"
    case welcome = "welcome_message"
    
    // Settings
    case settingsTitle = "settings_title"
    case language = "language"
    case darkMode = "dark_mode"
    case notifications = "notifications"
    case aiFeedback = "ai_feedback"

    // Writing Session
    case writingSessionTitle = "writing_session_title"
    case newPrompt = "new_prompt"
    case startTimer = "start_timer"
    case save = "save"
    case cancel = "cancel"
    
    // Feedback
    case feedbackTitle = "feedback_title"
    case improveGrammar = "improve_grammar"
    case enhanceStyle = "enhance_style"
    case improveStructure = "improve_structure"
    case boostCreativity = "boost_creativity"
    case increaseEngagement = "increase_engagement"
}

// MARK: - Localization Service
class LocalizationService: ObservableObject {
    @Published var currentLanguage: SupportedLanguage = .english

    // Get localized string for a given key
    func localizedString(for key: LocalizableKey) -> String {
        let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj") ?? ""
        let bundle = Bundle(path: path) ?? .main
        return NSLocalizedString(key.rawValue, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    // Switch app language
    func switchLanguage(to language: SupportedLanguage) {
        currentLanguage = language
        UserDefaults.standard.set(language.rawValue, forKey: "appLanguage")
    }

    // Load saved language
    func loadSavedLanguage() {
        if let savedLanguage = UserDefaults.standard.string(forKey: "appLanguage"),
           let language = SupportedLanguage(rawValue: savedLanguage) {
            currentLanguage = language
        }
    }
}

