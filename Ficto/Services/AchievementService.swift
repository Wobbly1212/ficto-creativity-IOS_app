//
//  AchievementService.swift
//  Inkspire
//
//  Created by Mehdi Javdaneh on 13/03/25.
//


import Foundation
import Combine

// MARK: - AchievementService (Updated)
class AchievementService: ObservableObject {
    private(set) var achievements: [Achievement] = Achievement.sampleAchievements
    private let userDefaultsKey = "userAchievements"
    
    // Published property to allow SwiftUI to observe changes
    @Published var unlockedAchievements: [Achievement] = []
    
    private var cancellables: Set<AnyCancellable> = []

    init() {
        loadAchievements()
    }

    // MARK: - Unlock Achievement
    func unlockAchievement(type: AchievementType) {
        guard let index = achievements.firstIndex(where: { $0.type == type && !$0.isUnlocked }) else { return }
        
        // Unlock the achievement
        achievements[index].isUnlocked = true
        achievements[index].unlockDate = Date()
        
        // Update the published unlocked achievements
        unlockedAchievements.append(achievements[index])
        
        // Save achievements after unlocking
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
        
        // Initialize unlockedAchievements from the stored data
        unlockedAchievements = achievements.filter { $0.isUnlocked }
    }
}
