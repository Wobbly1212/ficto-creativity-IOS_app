//
//  GamificationView.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct GamificationView: View {
    @ObservedObject var viewModel = GamificationViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Title
            Text("Gamification")
                .font(.largeTitle)
                .bold()
            
            // Points
            StatCardView(
                title: "Points",
                value: "\(viewModel.points)",
                icon: "star.fill",
                color: .yellow
            )
            
            // Total Words Written
            StatCardView(
                title: "Total Words Written",
                value: "\(viewModel.totalWordsWritten)",
                icon: "text.book.closed.fill",
                color: .green
            )
            
            // Badges Section
            VStack(alignment: .leading, spacing: 15) {
                Text("Badges")
                    .font(.headline)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(viewModel.badges) { badge in
                            BadgeView(badge: badge)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - Badge View
struct BadgeView: View {
    let badge: Badge
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "medal.fill")
                .font(.largeTitle)
                .foregroundColor(.orange)
                .padding()
                .background(Circle().fill(Color.white.opacity(0.2)))
            
            Text(badge.title)
                .font(.subheadline)
                .bold()
            
            Text(badge.description)
                .font(.caption)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.orange.opacity(0.2)))
        .frame(width: 120, height: 150)
    }
}

// MARK: - Preview
#Preview {
    GamificationView()
}
