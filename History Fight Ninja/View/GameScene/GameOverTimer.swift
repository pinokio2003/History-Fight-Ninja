import SwiftUI

struct FlipTimerEffect: View {
    var width: CGFloat = 160
    var height: CGFloat = 180

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
            .font(.system(size: 180))
            .foregroundColor(.white)
    }
}

//MARK: MainView

struct GameOverTimer: View {
    @State var timerStart: Int
    @State private var start: Bool = false
    @State private var stop: Bool = false
    @State private var num: Int
    @State private var numTwo: Int
    @State private var numThree: Int
    @State private var numFour: Int
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(timerStart: Int) {
        _timerStart = State(initialValue: timerStart)
        _num = State(initialValue: timerStart)
        _numTwo = State(initialValue: timerStart)
        _numThree = State(initialValue: timerStart)
        _numFour = State(initialValue: timerStart)
    }

    var body: some View {
        ZStack {
            FlipTimerEffect()
            NumberView(num: num)

            ZStack {
                FlipTimerEffect()
                NumberView(num: numTwo)
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
                NumberView(num: numThree)
            }
            .mask {
                FlipTimerEffect(height: 120)
                    .offset(y: 60)
            }
            ZStack {
                FlipTimerEffect()
                NumberView(num: numFour)
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
        .onReceive(timer) { _ in
            if num > 0 {
                num -= 1
                numTwo = num
                numThree = num
                numFour = num
                
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
            }
        }
    }
}

#Preview {
    GameOverTimer(timerStart: 9)
}
