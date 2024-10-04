//
//  StartButton.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 04.10.2024.
//

import SwiftUI

struct StartButton: View {
    let action: () -> Void
    @State private var isAnimating = false
    var text: String
    var isUpBubble: Bool
    
    
    var body: some View {
        Button(action: action) {
            ZStack {
                // Основная форма кнопки
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white.opacity(0.5))
                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.black, lineWidth: 2)
                    )
                // Текст кнопки
                
                Text(text)
                    .foregroundColor(.red)
                    .font(.custom("Cochin-BoldItalic", size: 35))
                    .fontWeight(.bold)
                    .shadow(color: .white, radius: 10, x: 2, y: 5)
                
                // Анимированные блики
                if isUpBubble {
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 20, height: 20)
                        .offset(x: isAnimating ? 50 : -50, y: -20)
                        .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true), value: isAnimating)
                } else {
                    Circle()
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 15, height: 15)
                        .offset(x: isAnimating ? -40 : 40, y: 20)
                        .animation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true).delay(1.5), value: isAnimating)
                }
            }
//            .frame(width: 100, height: 30)
        }
        .buttonStyle(PlainButtonStyle())
        .onAppear {
            isAnimating = true
        }
    }
}
