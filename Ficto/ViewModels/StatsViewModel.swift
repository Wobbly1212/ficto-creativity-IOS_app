//
//  StatsViewModel.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation

class StatsViewModel: ObservableObject {
    @Published var totalWordsWritten: Int = 0
    @Published var writingStreak: Int = 0
    @Published var badgesCount: Int = 0 // Store badge count from GamificationModel
    @Published var points: Int = 0
    @Published var progress: Double = 0.0
    @Published var weeklyStats: [Int] = Array(repeating: 0, count: 7)

    private let calendar = Calendar.current
    private let gamificationService = GamificationService() // Reference the Gamification service
    
    // Example localization dictionary
    private let localizationDict: [String: String] = [
        "stats_title": "Statistics",
        "points": "Points",
        "badges": "Badges",
        "total_words": "Total Words",
        "sessions_completed": "Sessions Completed",
        "progress_overview": "Progress Overview",
        "weekly_goal": "Weekly Goal"
    ]
    
    init() {
        loadStats()
        updateProgress()
        fetchBadgesCount()
    }
    
    /// Retrieves a localized string for a given key
    func localizedString(forKey key: String) -> String {
        return localizationDict[key] ?? key
    }
    
    func updateStats(with writing: Writing) {
        let wordCount = writing.content.split { $0.isWhitespace }.count
        totalWordsWritten += wordCount
        updateStreak()
        updatePoints(wordCount: wordCount)
        updateWeeklyStats(wordCount: wordCount)
        updateProgress()
        saveStats()
    }

    private func updateStreak() {
        let lastWrittenDate = UserDefaults.standard.object(forKey: "lastWrittenDate") as? Date ?? Date()
        if calendar.isDateInYesterday(lastWrittenDate) {
            writingStreak += 1
        } else if !calendar.isDateInToday(lastWrittenDate) {
            writingStreak = 1
        }
        UserDefaults.standard.set(Date(), forKey: "lastWrittenDate")
    }

    private func updatePoints(wordCount: Int) {
        points += wordCount / 10
    }

    private func updateProgress() {
        let targetWords = 5000.0
        progress = min(Double(totalWordsWritten) / targetWords, 1.0)
    }

    private func updateWeeklyStats(wordCount: Int) {
        let todayIndex = calendar.component(.weekday, from: Date()) - 1
        weeklyStats[todayIndex] += wordCount
    }

    private func fetchBadgesCount() {
        badgesCount = gamificationService.getBadges().count
    }

    private func saveStats() {
        UserDefaults.standard.set(totalWordsWritten, forKey: "totalWordsWritten")
        UserDefaults.standard.set(writingStreak, forKey: "writingStreak")
        UserDefaults.standard.set(points, forKey: "points")
        if let encoded = try? JSONEncoder().encode(weeklyStats) {
            UserDefaults.standard.set(encoded, forKey: "weeklyStats")
        }
    }

    private func loadStats() {
        totalWordsWritten = UserDefaults.standard.integer(forKey: "totalWordsWritten")
        writingStreak = UserDefaults.standard.integer(forKey: "writingStreak")
        points = UserDefaults.standard.integer(forKey: "points")
        if let data = UserDefaults.standard.data(forKey: "weeklyStats"),
           let savedStats = try? JSONDecoder().decode([Int].self, from: data) {
            weeklyStats = savedStats
        }
    }
}
