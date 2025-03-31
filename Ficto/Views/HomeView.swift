//
//  HomeView.swift
//  Inkspire
//
//  Created by Hosein Darabi on 05/03/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showWritingSession = false

    var body: some View {
        ZStack {
            // Animated Background
            AnimatedBackground()
                .ignoresSafeArea()
            Text("Your next story is just one tap away!")
                .font(.system(size: 22, weight: .bold, design: .default))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top, -290.0)
            VStack {
                Spacer()
               

                // Start Writing Circular Button (Centered)
                CircularButton(icon: "pencil", color: .indigo) {
                    showWritingSession = true
                }
                
                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showWritingSession) {
            NavigationStack {
                WritingSessionView(viewModel: WritingSessionViewModel())
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                showWritingSession = false
                            }) {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(.indigo)
                            }
                        }
                    }
            }
        }
    }
}

// MARK: - Circular Button Component
struct CircularButton: View {
    var icon: String
    var color: Color
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.white)
                .frame(width: 80, height: 80)
                .background(color)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .accessibilityLabel("Start Writing")
        .accessibilityHint("Starts a new writing session")
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
