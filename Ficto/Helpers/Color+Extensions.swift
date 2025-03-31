//
//  Color+Extensions.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

// MARK: - Custom Color Palette
extension Color {
    
    // MARK: - Primary Colors
    static let primaryBackground = Color("PrimaryBackground")
    static let secondaryBackground = Color("SecondaryBackground")
    static let primaryText = Color("PrimaryText")
    static let secondaryText = Color("SecondaryText")
    static let accentColor = Color("AccentColor")
    
    // MARK: - Button Colors
    static let primaryButton = Color("PrimaryButton")
    static let secondaryButton = Color("SecondaryButton")
    static let destructiveButton = Color("DestructiveButton")
    
    // MARK: - Feedback Colors
    static let positiveFeedback = Color("PositiveFeedback")
    static let neutralFeedback = Color("NeutralFeedback")
    static let negativeFeedback = Color("NegativeFeedback")
    
    // MARK: - Custom Gradients
    static let backgroundGradient = LinearGradient(
        gradient: Gradient(colors: [Color("GradientStart"), Color("GradientEnd")]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // MARK: - Tab Bar Colors
    static let tabBarBackground = Color("TabBarBackground")
    static let tabBarIcon = Color("TabBarIcon")
    
    // MARK: - Additional Custom Colors
    static let progressBarBackground = Color("ProgressBarBackground")
    static let progressBarFill = Color("ProgressBarFill")
    
    // MARK: - Dark Mode Support
    static func dynamicColor(light: Color, dark: Color) -> Color {
        return Color(UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
        })
    }
}

// MARK: - Preview
struct ColorExtensions_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            Text("Primary Background")
                .foregroundColor(.primaryText)
                .padding()
                .background(Color.primaryBackground)
                .cornerRadius(10)
            
            Text("Secondary Background")
                .foregroundColor(.secondaryText)
                .padding()
                .background(Color.secondaryBackground)
                .cornerRadius(10)
            
            Button("Primary Button") {}
                .padding()
                .background(Color.primaryButton)
                .foregroundColor(.white)
                .cornerRadius(10)
            
            Button("Destructive Button") {}
                .padding()
                .background(Color.destructiveButton)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        .background(Color.backgroundGradient)
        .previewLayout(.sizeThatFits)
    }
}
