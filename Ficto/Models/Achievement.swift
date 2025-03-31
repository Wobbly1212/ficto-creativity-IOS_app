//
//  AchievementType.swift
//  Inkspire
//
//  Created by Mehdi Javdaneh on 13/03/25.
//


import Foundation

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

// MARK: - Sample Achievements (optional)
extension Achievement {
    static let sampleAchievements: [Achievement] = [
        Achievement(type: .writingStreak, title: "Streak Starter", description: "Write for 3 consecutive days"),
        Achievement(type: .wordsWritten, title: "Wordsmith", description: "Write 1000 words in total"),
        Achievement(type: .promptsCompleted, title: "Prompt Master", description: "Complete 5 writing prompts"),
        Achievement(type: .dailyGoal, title: "Goal Getter", description: "Meet your daily writing goal 5 times"),
        Achievement(type: .consistency, title: "Consistent Creator", description: "Write consistently for a week")
    ]
}