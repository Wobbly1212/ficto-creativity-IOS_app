//
//  AnimatedBackground.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

/*import SwiftUI

struct AnimatedBackground: View {
    @State private var startAnimation = false

    // Define the colors outside the body to reduce complexity
    let colors: [Color] = [
        Color.red.opacity(0.3),
        Color.orange.opacity(0.3),
        Color.yellow.opacity(0.3),
        Color.green.opacity(0.3),
        Color.blue.opacity(0.3),
        Color.purple.opacity(0.3),
        Color.pink.opacity(0.3)
    ]

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [.blue.opacity(0.7), .purple.opacity(0.8), .pink.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Floating Circles
            ZStack {
                ForEach(0..<8, id: \.self) { index in
                    Circle()
                        .fill(colors.randomElement() ?? Color.blue.opacity(0.3)) // Use pre-defined colors
                        .frame(width: CGFloat.random(in: 200...300), height: CGFloat.random(in: 200...300))
                        .blur(radius: 40)
                        .offset(
                            x: startAnimation ? CGFloat.random(in: -250...250) : CGFloat.random(in: -150...150),
                            y: startAnimation ? CGFloat.random(in: -500...500) : CGFloat.random(in: -300...300)
                        )
                        .animation(
                            Animation.easeInOut(duration: 20)
                                .repeatForever(autoreverses: true),
                            value: startAnimation
                        )
                }
            }
            .onAppear {
                startAnimation = true
            }
        }
    }
}

// MARK: - Preview
#Preview {
    AnimatedBackground()
}
*/
