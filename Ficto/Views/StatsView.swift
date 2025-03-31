//
//  StatsView.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct StatsView: View {
    @ObservedObject var viewModel = StatsViewModel()

    var body: some View {
        ZStack {
            // Background
            AnimatedBackgroundTabs()
                .ignoresSafeArea()
                .accessibilityHidden(true)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Title aligned to the left
                    Text(viewModel.localizedString(forKey: "Progress"))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    // MARK: - Points & Badges (2x2 grid)
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        StatCardView(
                            title: viewModel.localizedString(forKey: "points"),
                            value: "\(viewModel.points)",
                            icon: "star.fill",
                            color: .yellow
                        )
                        
                        StatCardView(
                            title: viewModel.localizedString(forKey: "badges"),
                            value: "\(viewModel.badgesCount)", // Using badgesCount
                            icon: "medal.fill",
                            color: .orange
                        )
                        
                        StatCardView(
                            title: viewModel.localizedString(forKey: "total_words"),
                            value: "\(viewModel.totalWordsWritten)", // Fixed the property name here
                            icon: "text.book.closed.fill",
                            color: .green
                        )
                        
                        StatCardView(
                            title: viewModel.localizedString(forKey: "sessions_completed"),
                            value: "\(viewModel.writingStreak)", // Use writingStreak instead of sessionsCompleted
                            icon: "checkmark.circle.fill",
                            color: .blue
                        )
                    }
                    .padding(.horizontal)
                    
                    // MARK: - Progress Overview
                    VStack(alignment: .leading, spacing: 15) {
                        Text(viewModel.localizedString(forKey: "progress_overview"))
                            .font(.headline)
                            .foregroundColor(.white)
                        
                        ProgressBar(value: viewModel.progress)
                            .frame(height: 20)
                            .padding(.horizontal)
                        
                        HStack {
                            Text(viewModel.localizedString(forKey: "weekly_goal"))
                                .foregroundColor(.white.opacity(0.7))
                            Spacer()
                            Text("\(Int(viewModel.progress * 100))%")
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

// MARK: - Stat Card View
struct StatCardView: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
                .padding(10)
                .background(Circle().fill(Color.white.opacity(0.2)))
            
            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)  // Ensure equal sizing for all StatCards
        .background(RoundedRectangle(cornerRadius: 16).fill(Color.black.opacity(0.3)))
        .shadow(radius: 5)
    }
}

// MARK: - Progress Bar
struct ProgressBar: View {
    var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.2))
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .leading, endPoint: .trailing))
                    .frame(width: CGFloat(value) * geometry.size.width)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    StatsView()
}
