//
//  AnimationTableDefeat.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 12.10.2024.
//

import SwiftUI

struct AnimationTableDefeat: View {
    @State private var swing = false
    @State private var stopped = false
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack {
            Image("DefeatTable") // Ваше изображение таблички
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height) // Устанавливаем размер
//                .padding(.bottom, 180)
                .rotation3DEffect(
                    Angle.degrees(stopped ? 0 : (swing ? 25 : -25)), // Угол поворота: 0 при остановке
                    axis: (x: 1.0, y: 0.0, z: 0.0) // Ось X для имитации наклона
                )
                .scaleEffect(stopped ? 1.0 : (swing ? 1.2 : 0.8)) // Без изменения масштаба при остановке
                .animation(stopped ? .easeOut(duration: 1.0) : Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: swing)
                .onAppear {
                    resetAnimation()
                }
        }
    }
    
    private func resetAnimation() {
        // Останавливаем текущую анимацию перед перезапуском
        swing = false
        stopped = false
        
        // Перезапускаем анимацию с задержкой для плавного начала
        DispatchQueue.main.async {
            swing.toggle() // Запускаем качание
            
            // Останавливаем через 2.5 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                stopped = true // Прекращаем анимацию
                swing = false // Останавливаем качели
            }
        }
    }
}

#Preview {
    AnimationTableDefeat(width: 300, height: 300)
}
