//
//  CircularProgressBar.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct CircularProgressBar: View {
    var progress: Double // Value between 0.0 to 1.0 representing progress
    var lineWidth: CGFloat = 12 // Default line width
    var size: CGFloat = 150 // Default size for the progress bar
    var gradientColors: [Color] = [Color.blue, Color.purple, Color.pink] // Default gradient colors

    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)

            // Progress Circle
            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                .stroke(
                    AngularGradient(gradient: Gradient(colors: gradientColors),
                                    center: .center,
                                    startAngle: .degrees(0),
                                    endAngle: .degrees(360)),
                    style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)

            // Progress Percentage
            VStack {
                Text("\(Int(progress * 100))%")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)

                Text("Progress")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .frame(width: size, height: size)
        .padding()
        .background(Color.black.opacity(0.6))
        .clipShape(Circle())
        .shadow(radius: 10)
    }
}

// MARK: - Preview
#Preview {
    CircularProgressBar(progress: 0.7) // Preview with 70% progress
}
