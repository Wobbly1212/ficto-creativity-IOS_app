//
//  Achievements.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

/*import Foundation

// MARK: - AchievementType Enum
enum AchievementType: String, Codable {
    case writingStreak       // For consecutive days of writing
    case wordsWritten        // For reaching word count milestones
    case promptsCompleted    // For finishing a number of prompts
    case dailyGoal           // For meeting daily writing goals
    case consistency         // For maintaining consistent writing habits
}

// MARK: - Achievement Model
struct Achievement: Identifiable, Codable {
    var id = UUID()                  // Unique identifier for each achievement
    let type: AchievementType        // Type of achievement
    let title: String                // Achievement title
    let description: String          // Achievement description
    var isUnlocked: Bool = false     // Unlock status
    var unlockDate: Date? = nil      // Date when unlocked
}

// MARK: - Sample Achievements
extension Achievement {
    static let sampleAchievements: [Achievement] = [
        Achievement(type: .writingStreak, title: "Streak Starter", description: "Write for 3 consecutive days"),
        Achievement(type: .wordsWritten, title: "Wordsmith", description: "Write 1000 words in total"),
        Achievement(type: .promptsCompleted, title: "Prompt Master", description: "Complete 5 writing prompts"),
        Achievement(type: .dailyGoal, title: "Goal Getter", description: "Meet your daily writing goal 5 times"),
        Achievement(type: .consistency, title: "Consistent Creator", description: "Write consistently for a week")
    ]
}

// MARK: - AchievementService
class AchievementService {
    private(set) var achievements: [Achievement] = Achievement.sampleAchievements
    private let userDefaultsKey = "userAchievements"
    
    init() {
        loadAchievements()
    }
    
    // MARK: - Unlock Achievement
    func unlockAchievement(type: AchievementType) {
        guard let index = achievements.firstIndex(where: { $0.type == type && !$0.isUnlocked }) else { return }
        achievements[index].isUnlocked = true
        achievements[index].unlockDate = Date()
        saveAchievements()
    }
    
    // MARK: - Check Achievement Status
    func isAchievementUnlocked(type: AchievementType) -> Bool {
        return achievements.first(where: { $0.type == type })?.isUnlocked ?? false
    }
    
    // MARK: - Save Achievements
    private func saveAchievements() {
        if let encoded = try? JSONEncoder().encode(achievements) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    // MARK: - Load Achievements
    private func loadAchievements() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([Achievement].self, from: savedData) {
            achievements = decoded
        }
    }
}

// MARK: - Testing Achievements
struct AchievementTester {
    static func run() {
        let service = AchievementService()
        service.unlockAchievement(type: .writingStreak)
        print("✅ Unlocked Achievements: \(service.achievements.filter { $0.isUnlocked })")
    }
}

*/
