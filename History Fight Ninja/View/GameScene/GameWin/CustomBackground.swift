//
//  CustomBackground.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 03.07.2024.
//

import SwiftUI

struct Firework: View {
    let colors: [Color] = [.red, .yellow, .green, .blue, .purple, .orange]
    @State private var scale: CGFloat = 0.1
    @State private var opacity: Double = 1.0
    @State private var position: CGPoint = .zero

    var body: some View {
        Circle()
            .fill(colors.randomElement()!)
            .frame(width: 30, height: 30)
            .scaleEffect(scale)
            .opacity(opacity)
            .position(position)
            .onAppear {
                position = CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                   y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
                withAnimation(.easeOut(duration: 1)) {
                    scale = CGFloat.random(in: 1...2)
                    opacity = 0
                }
            }
    }
}

struct CustomBackground: View {
    @State private var start = UnitPoint(x: 0, y: 0)
    @State private var end = UnitPoint(x: 1, y: 1)
    @State private var fireworks: [UUID] = []
    
    let timer = Timer.publish(every: 5, on: .main, in: .default).autoconnect()
    let fireworkTimer = Timer.publish(every: 0.5, on: .main, in: .default).autoconnect()
    let colors = [Color.blue, Color.cyan, Color.indigo.opacity(0.5)]
    
    var body: some View {
        ZStack {
            Image("BackgroundWinner")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 5)
            
//            LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
//                .animation(.easeInOut(duration: 13).repeatForever(), value: start)
//                .onReceive(timer) { _ in
//                    self.start = UnitPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
//                    self.end = UnitPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
//                }
//            
            ForEach(fireworks, id: \.self) { _ in
                Firework()
            }
        }
        .onReceive(fireworkTimer) { _ in
            if fireworks.count < 20 {
                fireworks.append(UUID())
            }
            if fireworks.count > 15 {
                fireworks.removeFirst()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    CustomBackground()
}
