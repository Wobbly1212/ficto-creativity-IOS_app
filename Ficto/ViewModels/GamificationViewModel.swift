//
//  GamificationViewModel.swift
//  Inkspire
//
//  Created by Mehdi Javdaneh on 11/03/25.
//


import Foundation

class GamificationViewModel: ObservableObject {
    @Published var badges: [Badge] = []
    @Published var points: Int = 0
    @Published var totalWordsWritten: Int = 0
    
    private let gamificationService = GamificationService() // Reference to the service

    init() {
        loadGamificationData()
    }
    
    // Load badges and points from the GamificationService
    func loadGamificationData() {
        badges = gamificationService.getBadges()
        points = gamificationService.getPoints()  // Now accessing via the public method
        totalWordsWritten = gamificationService.getTotalWordsWritten()  // Accessing via public method
    }
    
    // Function to add a new badge
    func addBadge(badge: Badge) {
        gamificationService.addBadge(badge: badge)
        loadGamificationData() // Refresh data after adding a badge
    }
    
    // Update the points earned
    func updatePoints(points: Int) {
        gamificationService.updatePoints(points: points)
        loadGamificationData() // Refresh data after updating points
    }
    
    // Update total words written
    func updateTotalWordsWritten(words: Int) {
        gamificationService.updateTotalWordsWritten(words: words)
        loadGamificationData() // Refresh data after updating words
    }
}
