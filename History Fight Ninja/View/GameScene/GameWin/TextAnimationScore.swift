//
//  TextAnimationScore.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 02.07.2024.
//

import SwiftUI

struct TextAnimationScore: View {
    ///config
    var text: String
    var trigger: Bool
    var duration: Double = 0.8
    var speed: CGFloat = 0.1
    ///View Properties
    @State private var animatedText: String = ""
    @State private var randomCharacters: [Character] = {
        let string = "abcdefghijklmnopqrstuvwxyZABCDEFGHIJKLMNOPQRSTUWVXYZ0123456789-/#$%@^&＊"
        return Array(string)
    }()
    
    var body: some View {
        Text(animatedText)
//            .font(.system(.body, design: .monospaced))
            .font(.custom("MarkerFelt-Thin", size: 30))
            .truncationMode(.tail)
            .transition(.opacity)
            .animation(.easeInOut(duration: 0.1), value: animatedText)
            .onAppear {
                guard animatedText.isEmpty else {return}
                setRundomCharacter()
                animateText()
            }
            .onChange(of: trigger, perform: { value in
                animateText()
            })
    }
    
    private func animateText() {
        for index in text.indices {
            let delay = CGFloat.random(in: 0...duration)
            let timer = Timer.scheduledTimer(withTimeInterval: speed,
                                             repeats: true) { _ in
                guard let randomCharacter = randomCharacters.randomElement() else {return}
                replaceCharacter(at: index, character: randomCharacter)
            }
            timer.fire()
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                if text.indices.contains(index) {
                    let actualCharacter = text[index]
                    replaceCharacter(at: index, character: actualCharacter)
                }
                timer.invalidate()
            }
        }
    }
    
    private func setRundomCharacter() {
        animatedText = text
        
        for index in animatedText.indices {
            guard let randomCharacter = randomCharacters.randomElement() else {return}
            replaceCharacter(at: index, character: randomCharacter)
        }
    }
    
    func replaceCharacter(at index: String.Index, character: Character) {
        guard animatedText.indices.contains(index) else {return}
        let indexCharacter = String(animatedText[index])
        
        if indexCharacter.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            animatedText.replaceSubrange(index...index, with: String(character))
        }
    }
}


#Preview {
    ScoreBoardView()
}
