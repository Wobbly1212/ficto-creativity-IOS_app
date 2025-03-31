//
//  SettingsViewModel.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation

/// ViewModel to manage user settings in the Settings View.
class SettingsViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedLanguage: LanguageService.Language
    @Published var isDarkModeEnabled: Bool
    @Published var notificationsEnabled: Bool
    @Published var aiFeedbackEnabled: Bool
    
    // MARK: - References
    class UserSettings {
        static let shared = UserSettings()  // Singleton instance
        
        // Store user preferences here
        var selectedLanguage: LanguageService.Language = .english
        var isDarkModeEnabled: Bool = false
        var notificationsEnabled: Bool = true
        var aiFeedbackEnabled: Bool = true
        
        private init() {}  // Private initializer to ensure singleton pattern
    }
    
    private let userSettings = UserSettings.shared  // Accessing the singleton
    
    // MARK: - Initializer
    init() {
        self.selectedLanguage = userSettings.selectedLanguage
        self.isDarkModeEnabled = userSettings.isDarkModeEnabled
        self.notificationsEnabled = userSettings.notificationsEnabled
        self.aiFeedbackEnabled = userSettings.aiFeedbackEnabled
    }
    
    // MARK: - Methods to Update Settings
    func updateLanguage(to language: LanguageService.Language) {
        // Update the selected language
        selectedLanguage = language
        userSettings.selectedLanguage = language
        
        // Update the language in LanguageService
        LanguageService.shared.setLanguage(language)  // Ensure the language is updated in LanguageService
    }
    
    func toggleDarkMode() {
        isDarkModeEnabled.toggle()
        userSettings.isDarkModeEnabled = isDarkModeEnabled
    }
    
    func toggleNotifications() {
        notificationsEnabled.toggle()
        userSettings.notificationsEnabled = notificationsEnabled
    }
    
    func toggleAIFeedback() {
        aiFeedbackEnabled.toggle()
        userSettings.aiFeedbackEnabled = aiFeedbackEnabled
    }
    
    func localizedString(forKey key: String) -> String {
        // Assuming you have some localization logic
        return NSLocalizedString(key, comment: "")
    }
    
    func setLanguage(_ language: LanguageService.Language) {
        // Logic to update the language in your view model or app settings
        self.selectedLanguage = language
    }
}
