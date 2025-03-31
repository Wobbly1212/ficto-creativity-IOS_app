//
//  InkspireApp.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

@main
struct InkspireApp: App {
    // MARK: - App-wide ViewModels
    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject private var languageService = LanguageService()
    @StateObject private var achievementIconService = AchievementService()
    @StateObject private var statsViewModel = StatsViewModel()
    @StateObject private var feedbackViewModel = FeedbackViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settingsViewModel)
                .environmentObject(languageService)
                .environmentObject(achievementIconService)
                .environmentObject(statsViewModel)
                .environmentObject(feedbackViewModel)
                .preferredColorScheme(settingsViewModel.isDarkModeEnabled ? .dark : .light)
        }
    }
}
