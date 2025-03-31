//
//  GamificationService.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation

class GamificationService {
    private var gamificationData = GamificationData(badges: [], points: 0, totalWordsWritten: 0)

    // Public methods to access the private gamificationData properties
    func getPoints() -> Int {
        return gamificationData.points
    }

    func getTotalWordsWritten() -> Int {
        return gamificationData.totalWordsWritten
    }

    func getBadges() -> [Badge] {
        return gamificationData.badges
    }

    func addBadge(badge: Badge) {
        gamificationData.badges.append(badge)
    }

    func updatePoints(points: Int) {
        gamificationData.points += points
    }

    func updateTotalWordsWritten(words: Int) {
        gamificationData.totalWordsWritten += words
    }
}
