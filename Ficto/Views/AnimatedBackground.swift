import SwiftUI

struct AnimatedBackground: View {
    @State private var animateGalaxy = false
    @State private var shootingStarVisible = false
    @State private var nebulaOpacity: Double = 0.4
    @State private var touchLocation: CGPoint = .zero
    @State private var showRipple = false

    var body: some View {
        ZStack {
            // Galaxy Gradient Core
            RadialGradient(
                gradient: Gradient(colors: [.blue, .black]),
                center: .center,
                startRadius: 50,
                endRadius: 500
            )
            .ignoresSafeArea()

            // Rotating Spiral Galaxy Core
            SpiralGalaxy()
                .frame(width: 400, height: 400)
                .opacity(0.6)
                .rotationEffect(.degrees(animateGalaxy ? 360 : 0))
                .animation(Animation.linear(duration: 20).repeatForever(autoreverses: false), value: animateGalaxy)

            // Nebula Clouds
            NebulaView(opacity: $nebulaOpacity)
                .blendMode(.screen)
                .animation(Animation.easeInOut(duration: 6).repeatForever(autoreverses: true), value: nebulaOpacity)

            // Shooting Star
         /*   if shootingStarVisible {
                ShootingStar()
                    .offset(x: CGFloat.random(in: -200...200), y: CGFloat.random(in: -200...200))
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1)) {
                            shootingStarVisible = false
                        }
                    }
            }

            // Ripple Effect on Touch
            if showRipple {
                RippleEffect(center: touchLocation)
            }*/

            // Star Field
            ForEach(0..<150, id: \.self) { _ in
                StarView(size: CGFloat.random(in: 2...4), opacity: Double.random(in: 0.5...0.9))
                    .offset(x: CGFloat.random(in: -500...500), y: CGFloat.random(in: -800...800))
            }

            // Planetary Motion
       /*     PlanetView(size: 100, color: .orange)
                .offset(x: animateGalaxy ? 200 : -200, y: -300)
                .animation(Animation.easeInOut(duration: 12).repeatForever(autoreverses: true), value: animateGalaxy)*/
        }
        .onAppear {
            animateGalaxy = true

            // Trigger shooting stars periodically
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                shootingStarVisible = true
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    touchLocation = value.location
                    showRipple = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        showRipple = false
                    }
                }
        )
    }
}

// MARK: - Spiral Galaxy
struct SpiralGalaxy: View {
    var body: some View {
        ZStack {
            ForEach(0..<10, id: \.self) { index in
                Circle()
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: [.white.opacity(0.2), .purple.opacity(0.6), .clear]),
                            center: .center
                        ),
                        lineWidth: CGFloat(index) * 2
                    )
                    .scaleEffect(CGFloat(index) * 0.1)
                    .blendMode(.screen)
            }
        }
    }
}

// MARK: - Nebula View
struct NebulaView: View {
    @Binding var opacity: Double

    var body: some View {
        ZStack {
            ForEach(0..<3, id: \.self) { _ in
                Ellipse()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.blue.opacity(0.3), .pink.opacity(0.5), .clear]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 400, height: 300)
                    .rotationEffect(.degrees(Double.random(in: 0...360)))
                    .opacity(opacity)
            }
        }
    }
}

// MARK: - Shooting Star
struct ShootingStar: View {
    var body: some View {
        Capsule()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [.white, .clear]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: 150, height: 2)
            .offset(x: -150)
            .rotationEffect(.degrees(-45))
            .animation(Animation.easeInOut(duration: 1))
    }
}

// MARK: - Ripple Effect
struct RippleEffect: View {
    let center: CGPoint

    var body: some View {
        Circle()
            .strokeBorder(Color.white.opacity(0.5), lineWidth: 2)
            .frame(width: 100, height: 100)
            .position(x: center.x, y: center.y)
            .opacity(0.6)
            .scaleEffect(1.5)
            .animation(Animation.easeOut(duration: 1), value: center)
    }
}

// MARK: - Star View
struct StarView: View {
    let size: CGFloat
    let opacity: Double

    var body: some View {
        Circle()
            .frame(width: size, height: size)
            .foregroundColor(.white.opacity(opacity))
            .blur(radius: 1)
    }
}

// MARK: - Planet View
struct PlanetView: View {
    let size: CGFloat
    let color: Color

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: size, height: size)
            .shadow(color: color.opacity(0.6), radius: 10)
    }
}


struct GalaxyCoreView: View {
    @State private var animateSpiral = false
    @State private var coreGlowIntensity: Double = 0.7
    @State private var touchLocation = CGPoint(x: 0, y: 0)
    @State private var showFlares = false

    var body: some View {
        ZStack {
            // Central Glowing Core
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(coreGlowIntensity),
                            Color.purple.opacity(0.8),
                            Color.black.opacity(0.5)
                        ]),
                        center: .center,
                        startRadius: 10,
                        endRadius: 100
                    )
                )
                .frame(width: 200, height: 200)
                .shadow(color: Color.purple.opacity(0.7), radius: 30)
                .scaleEffect(animateSpiral ? 1.2 : 1.0)
                .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animateSpiral)
                .onTapGesture {
                    showFlares = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showFlares = false
                    }
                }

            // Spiral Arms
            ForEach(0..<4, id: \.self) { index in
                SpiralArmView(rotationAngle: Double(index) * 90, layer: index + 1)
                    .rotationEffect(.degrees(animateSpiral ? 360 : 0))
                    .animation(
                        Animation.linear(duration: Double(5 + index)).repeatForever(autoreverses: false),
                        value: animateSpiral
                    )
            }

            // Dust Clouds
            Circle()
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [Color.purple.opacity(0.5), Color.clear]),
                        center: .center
                    ),
                    lineWidth: 50
                )
                .frame(width: 300, height: 300)
                .rotationEffect(.degrees(animateSpiral ? -180 : 0))
                .blur(radius: 20)
                .animation(Animation.linear(duration: 8).repeatForever(autoreverses: false), value: animateSpiral)

            // Lens Flare Effect
            if showFlares {
                FlareView(center: touchLocation)
            }
        }
        .onAppear {
            animateSpiral = true
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    touchLocation = value.location
                    showFlares = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showFlares = false
                    }
                }
        )
    }
}

// MARK: - Spiral Arm View
struct SpiralArmView: View {
    let rotationAngle: Double
    let layer: Int

    var body: some View {
        ZStack {
            ForEach(0..<10, id: \.self) { index in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color.white.opacity(Double(layer) * 0.1))
                    .offset(x: CGFloat(index * 20), y: 0)
                    .blur(radius: 1)
            }
        }
        .rotationEffect(.degrees(rotationAngle))
        .offset(x: 0, y: 0)
    }
}

// MARK: - Flare View
struct FlareView: View {
    let center: CGPoint

    var body: some View {
        Circle()
            .stroke(
                RadialGradient(
                    gradient: Gradient(colors: [Color.yellow, Color.clear]),
                    center: .center,
                    startRadius: 0,
                    endRadius: 50
                ),
                lineWidth: 2
            )
            .frame(width: 100, height: 100)
            .position(x: center.x, y: center.y)
            .opacity(0.6)
            .scaleEffect(1.5)
            .animation(Animation.easeOut(duration: 0.5), value: center)
    }
}


// MARK: - Preview
#Preview {
    AnimatedBackground()
}
