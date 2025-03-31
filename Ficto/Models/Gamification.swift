//
//  Badge.swift
//  Inkspire
//
//  Created by Mehdi Javdaneh on 11/03/25.
//

import Foundation

struct Badge: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
}

struct GamificationData: Codable {
    var badges: [Badge] = []
    var points: Int = 0
    var totalWordsWritten: Int = 0
}
