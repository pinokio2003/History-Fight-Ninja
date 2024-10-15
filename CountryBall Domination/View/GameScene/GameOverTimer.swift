import SwiftUI

struct FlipTimerEffect: View {
    var width: CGFloat = 80
    var height: CGFloat = 120

    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .frame(width: width, height: height)
            .foregroundColor(Color.gray)
    }
}

struct NumberView: View {
    var num: Int
    var body: some View {
        Text("\(num)")
            .font(.system(size: 120))
            .foregroundColor(.white)
    }
}

struct FlipDigitView: View {
    var num: Int
    @Binding var start: Bool
    @Binding var stop: Bool

    var body: some View {
        ZStack {
            FlipTimerEffect()
            NumberView(num: num)

            ZStack {
                FlipTimerEffect()
                NumberView(num: num)
            }
            .mask {
                FlipTimerEffect(height: 120)
                    .offset(y: -60)
            }
            .rotation3DEffect(.degrees(start ? 90 : 0),
                              axis: (x: -1, y: 0.0, z: 0.0),
                              anchor: .center,
                              anchorZ: 0.0,
                              perspective: 0.5
            )
            ZStack {
                FlipTimerEffect()
                NumberView(num: num)
            }
            .mask {
                FlipTimerEffect(height: 120)
                    .offset(y: 60)
            }
            ZStack {
                FlipTimerEffect()
                NumberView(num: num)
            }
            .mask {
                FlipTimerEffect()
                    .offset(y: 60)
            }
            .rotation3DEffect(.degrees(stop ? 0 : 90),
                              axis: (x: 1, y: 0.0, z: 0.0),
                              anchor: .center,
                              anchorZ: 0.0,
                              perspective: 0.5)
        }
        .overlay(content: {
            Rectangle().frame(height: 3)
                .foregroundColor(.white)
                .offset(y: 1.5)
        })
    }
}

struct GameOverTimer: View {
    @State private var timerStart: Int
    @State private var start: Bool = false
    @State private var stop: Bool = false

    @State private var tens: Int
    @State private var units: Int

    @State private var timerActive: Bool = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(timerStart: Int) {
        _timerStart = State(initialValue: timerStart)
        _tens = State(initialValue: timerStart / 10)
        _units = State(initialValue: timerStart % 10)
    }

    var body: some View {
        HStack {
            FlipDigitView(num: tens, start: $start, stop: $stop)
            FlipDigitView(num: units, start: $start, stop: $stop)
        }
        .onReceive(timer) { time in
            print(timerStart)
            guard timerActive else { return }
            if timerStart > 0 {
                timerStart -= 1
                tens = timerStart / 10
                units = timerStart % 10

                withAnimation(.spring().speed(3)) {
                    start.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    start = false
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring().speed(3)) {
                        stop = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    stop = false
                }
            } else {
                timerActive = false
                timer.upstream.connect().cancel()  // Cancel the timer
            }
        }
    }
}

#Preview {
    GameOverTimer(timerStart: 8)
}
