//
//  UserStats.swift
//  Memory Sparks
//
//  Created by Hosein Darabi on 09/12/24.
//

import Foundation

/// Enum for different types of stats tracked.
enum StatType: String, Codable {
    case wordsWritten
    case sessionsCompleted
    case longestStreak
    case pointsEarned
}

/// Renamed from 'Badge' to avoid ambiguity.
struct AchievementBadge: Codable {
    let id: UUID
    let name: String
    let description: String
    let icon: String
}

/// Struct to hold user stats that are Codable.
struct UserStatsData: Codable {
    var wordsWritten: Int
    var sessionsCompleted: Int
    var longestStreak: Int
    var currentStreak: Int
    var pointsEarned: Int
    var badges: [AchievementBadge]  // Use the new type
}

/// Manages user statistics and gamification progress.
class UserStatsManager: ObservableObject {
    static let shared = UserStatsManager()  // Singleton instance
    
    // Observable properties for UI updates.
    @Published private(set) var wordsWritten: Int = 0
    @Published private(set) var sessionsCompleted: Int = 0
    @Published private(set) var longestStreak: Int = 0
    @Published private(set) var currentStreak: Int = 0
    @Published private(set) var pointsEarned: Int = 0
    @Published private(set) var badges: [AchievementBadge] = []  // Use the new type
    
    private let userDefaults = UserDefaults.standard
    
    private init() {
        loadStats()
    }
    
    /// Updates a specific stat.
    func updateStat(type: StatType, by amount: Int = 1) {
        switch type {
        case .wordsWritten:
            wordsWritten += amount
        case .sessionsCompleted:
            sessionsCompleted += amount
        case .longestStreak:
            currentStreak += amount
            if currentStreak > longestStreak {
                longestStreak = currentStreak
            }
        case .pointsEarned:
            pointsEarned += amount
        }
        checkForBadges()  // Check if new badges should be awarded
        saveStats()        // Save updated stats
    }
    
    /// Resets the current streak if a session is missed.
    func resetStreak() {
        currentStreak = 0
        saveStats()
    }
    
    /// Adds a new badge if conditions are met.
    func addBadge(name: String, description: String, icon: String) {
        let newBadge = AchievementBadge(id: UUID(), name: name, description: description, icon: icon)
        badges.append(newBadge)
        saveStats()
    }
    
    /// Checks if the user qualifies for any new badges.
    private func checkForBadges() {
        if wordsWritten >= 1000, !badges.contains(where: { $0.name == "Wordsmith" }) {
            addBadge(name: "Wordsmith", description: "Write 1000 words.", icon: "wordsmith_icon")
        }
        if sessionsCompleted >= 10, !badges.contains(where: { $0.name == "Dedicated Writer" }) {
            addBadge(name: "Dedicated Writer", description: "Complete 10 writing sessions.", icon: "dedicated_writer_icon")
        }
    }
    
    /// Saves stats to UserDefaults.
    private func saveStats() {
        let userStatsData = UserStatsData(
            wordsWritten: wordsWritten,
            sessionsCompleted: sessionsCompleted,
            longestStreak: longestStreak,
            currentStreak: currentStreak,
            pointsEarned: pointsEarned,
            badges: badges
        )
        
        do {
            let data = try JSONEncoder().encode(userStatsData)
            userDefaults.set(data, forKey: "userStats")
        } catch {
            print("❌ Failed to save user stats: \(error.localizedDescription)")
        }
    }
    
    /// Loads stats from UserDefaults.
    private func loadStats() {
        if let data = userDefaults.data(forKey: "userStats") {
            do {
                let decodedStats = try JSONDecoder().decode(UserStatsData.self, from: data)
                self.wordsWritten = decodedStats.wordsWritten
                self.sessionsCompleted = decodedStats.sessionsCompleted
                self.longestStreak = decodedStats.longestStreak
                self.currentStreak = decodedStats.currentStreak
                self.pointsEarned = decodedStats.pointsEarned
                self.badges = decodedStats.badges
            } catch {
                print("❌ Failed to load user stats: \(error.localizedDescription)")
            }
        }
    }
}
