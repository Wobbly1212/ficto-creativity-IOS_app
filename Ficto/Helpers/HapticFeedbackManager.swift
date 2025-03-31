//
//  HapticFeedbackManager.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import Foundation
import UIKit

// MARK: - HapticFeedbackManager
enum HapticFeedbackType {
    case light
    case medium
    case heavy
    case success
    case warning
    case error
}

struct HapticFeedbackManager {
    
    // MARK: - Trigger Haptic Feedback
    static func trigger(_ type: HapticFeedbackType) {
        switch type {
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.prepare()
            generator.impactOccurred()
            
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
            
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.prepare()
            generator.impactOccurred()
            
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.success)
            
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.warning)
            
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(.error)
        }
    }
}

// MARK: - Usage Examples
struct HapticFeedbackManager_Previews {
    static func run() {
        HapticFeedbackManager.trigger(.light)
        HapticFeedbackManager.trigger(.medium)
        HapticFeedbackManager.trigger(.heavy)
        HapticFeedbackManager.trigger(.success)
        HapticFeedbackManager.trigger(.warning)
        HapticFeedbackManager.trigger(.error)
        print("✅ Haptic feedback triggered successfully.")
    }
}


