//
//  ContentView.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var languageService: LanguageService
    @EnvironmentObject var achievementService: AchievementService  // Change here
    @EnvironmentObject var statsViewModel: StatsViewModel
    @EnvironmentObject var feedbackViewModel: FeedbackViewModel

    @State private var selectedTab: Tab = .home

    enum Tab {
        case home, history, stats, settings
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // Home View
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)

            // History View
            HistoryView(viewModel: HistoryViewModel.shared)
                .tabItem {
                    Label("History", systemImage: "book.fill")
                }
                .tag(Tab.history)

            // Stats View
            StatsView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar.fill")
                }
                .tag(Tab.stats)

            // Settings View
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(Tab.settings)
        }
        .accentColor(.white)
        
        .onAppear {
            UITabBar.appearance().unselectedItemTintColor = .darkGray
            if settingsViewModel.isDarkModeEnabled {
                UITabBar.appearance().backgroundColor = UIColor.gray
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SettingsViewModel())
        .environmentObject(LanguageService())  // Make sure LanguageService is properly initialized
        .environmentObject(AchievementService())  // Add AchievementService here
        .environmentObject(StatsViewModel())
        .environmentObject(FeedbackViewModel())
        .environmentObject(HistoryViewModel())
}

