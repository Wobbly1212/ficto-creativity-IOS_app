//
//  Animation+Extensions.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

// MARK: - Custom Animation Extensions
extension Animation {
    
    /// Creates a smooth and ease-in-out animation for standard UI transitions.
    static var smoothEase: Animation {
        Animation.easeInOut(duration: 0.5)
    }
    
    /// Creates a bounce effect for interactive elements.
    static var bounce: Animation {
        Animation.interpolatingSpring(stiffness: 170, damping: 15)
    }
    
    /// Creates a pulsating animation, useful for attention-seeking elements like buttons.
    static var pulsate: Animation {
        Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)
    }
}

// MARK: - Custom View Modifiers for Animations
extension View {
    
    /// Applies a smooth fade transition to the view.
    func fadeTransition() -> some View {
        self.transition(.opacity).animation(.smoothEase)
    }
    
    /// Applies a slide-in effect from the bottom.
    func slideInFromBottom() -> some View {
        self.transition(.move(edge: .bottom)).animation(.smoothEase)
    }
    
    /// Applies a bouncing effect, suitable for buttons or cards.
    func bounceEffect() -> some View {
        self.scaleEffect(1.1)
            .animation(.bounce)
    }
    
    /// Applies a pulsating effect to draw attention.
    func pulsatingEffect() -> some View {
        self.scaleEffect(1.1)
            .animation(.pulsate)
    }
}

// MARK: - Custom Animations for Specific UI Components
struct ShakeEffect: GeometryEffect {
    var travelDistance: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: travelDistance * sin(animatableData * .pi * CGFloat(shakesPerUnit)), y: 0))
    }
}

extension View {
    /// Applies a shake effect to the view for error indications.
    func shakeEffect() -> some View {
        self.modifier(ShakeEffect(animatableData: 1))
    }
}

