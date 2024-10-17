import SwiftUI

struct FallingLetterView: View {
    @State private var offsetY: CGFloat = -300 // Начальная позиция за пределами экрана
    @State private var bouncing: Bool = false // Для управления подпрыгиванием
    @State private var isFalling: Bool = true // Для анимации падения
    @State private var scale: CGFloat = 1.0 // Эффект масштабирования
    @State private var colorChange: Bool = false // Для смены цвета

    var letter: String
    var distance: CGFloat // Дистанция до точки остановки
    var angle: Double // Градус наклона буквы
    var initialColor: Color // Исходный цвет

    var body: some View {
        Text(letter)
            .font(.custom("Eracake", size: 75))
            .fontWeight(.bold)
            .foregroundColor(colorChange ? Color.white.opacity(0.7) : initialColor)
            .rotationEffect(.degrees(angle)) // Поворот буквы
            .offset(y: offsetY)
            .shadow(color: .black, radius: 8, x: 2, y: 2)
            .scaleEffect(scale)
            .overlay(
                Text(letter)
                    .font(.custom("Eracake", size: 78))
                    .foregroundColor(.red)
                    .fontWeight(.bold)
                    .rotationEffect(.degrees(angle))
                    .offset(y: offsetY)
                    .shadow(color: .white, radius: 4, x: 2, y: 2)
                
            )
            .onAppear {
                startFallingAnimation()
            }
            .onTapGesture {
                resetAndAnimate() // Перезапуск анимации при нажатии
            }
    }

    private func startFallingAnimation() {
        withAnimation(.easeIn(duration: 1.5)) {
            offsetY = distance // Анимация падения до точки остановки
            scale = 1.2 // Увеличиваем масштаб при падении
            colorChange.toggle() // Меняем цвет
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            bouncingAnimation()
        }
    }

    private func bouncingAnimation() {
        withAnimation(.interpolatingSpring(stiffness: 150, damping: 10)) {
            offsetY -= 30 // Первый прыжок
            scale = 0.9 // Уменьшение размера при первом прыжке
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.interpolatingSpring(stiffness: 100, damping: 8)) {
                offsetY += 30 // Возврат в исходное положение
                scale = 1.1 // Масштаб при возврате
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.interpolatingSpring(stiffness: 80, damping: 5)) {
                offsetY -= 15 // Второй подпрыгивание
                scale = 1.0 // Возвращаем масштаб к норме
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation(.interpolatingSpring(stiffness: 70, damping: 6)) {
                    offsetY += 15 // Окончательная остановка
                }
            }
        }
    }

    private func resetAndAnimate() {
        // Сбрасываем значения и запускаем анимацию заново
        offsetY = -300
        colorChange = false
        scale = 1.0
        startFallingAnimation()
    }
}
import SwiftUI

struct SlidingLetterView: View {
    @State private var offsetX: CGFloat = -UIScreen.main.bounds.width // Начальная позиция за пределами экрана слева
    var letter: String
    var angle: Double // Градус наклона буквы
    var letterColor: Color // Цвет буквы

    var body: some View {
        Text(letter)
            .font(.custom("Eracake", size: 55))
            .fontWeight(.bold)
            .foregroundColor(letterColor)
            .rotationEffect(.degrees(angle))
            .shadow(color: .white, radius: 5, x: 2, y: 2)
            .offset(x: offsetX)
            .onAppear {
                withAnimation(.interpolatingSpring(stiffness: 70, damping: 8)) {
                    offsetX = 0 // Анимация движения слева направо с инерцией
                }
            }
    }
}

struct FallingTextView: View {
    @State private var isSliding: Bool = false

    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                FallingLetterView(letter: "C", distance: 50, angle: -35, initialColor: .red)
                FallingLetterView(letter: "o", distance: 15, angle: -30, initialColor: .orange)
                FallingLetterView(letter: "u", distance: -5, angle: -15, initialColor: .yellow)
                FallingLetterView(letter: "n", distance: -25, angle: -15, initialColor: .green)
                FallingLetterView(letter: "t", distance: -35, angle: -5, initialColor: .blue)
                FallingLetterView(letter: "r", distance: -40, angle: 0, initialColor: .indigo)
                FallingLetterView(letter: "y", distance: -35, angle: 12, initialColor: .purple)
                FallingLetterView(letter: "B", distance: -20, angle: 25, initialColor: .pink)
                FallingLetterView(letter: "a", distance: 5, angle: 30, initialColor: .red)
                FallingLetterView(letter: "l", distance: 25, angle: 35, initialColor: .orange)
                FallingLetterView(letter: "l", distance: 50, angle: 35, initialColor: .yellow)
            }
            
            if isSliding {
                SlidingLetterView(letter: "DOMINATION", angle: 0, letterColor: .black.opacity(0.8))
                    .padding(.top, 150)
            }
        }
        .padding(.bottom, 150)
        .onAppear {
            // Задержка в 2 секунды перед включением isSliding
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
                withAnimation {
                    isSliding = true
                }
            }
        }
    }
}
