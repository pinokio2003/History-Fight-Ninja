//
//  ScoreBoardView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 27.06.2024.
//

import SwiftUI

struct ScoreBoardView: View {
    private let heroData = HeroData.shared
    
    var body: some View {
        let time = String(heroData.gameTime)
        let score = String(heroData.playerScore)
        
        ZStack {
            CustomBackground()
                .background(.quaternary)
            
            VStack {
                //Winning text
                Text("YOU WIN !!!")
                    .font(.custom("MarkerFelt-Thin", size: 60))
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    .padding(.top, 10)
                //Score
                HStack {
                    Spacer()
                    Text("Score board: ")
                        .font(.custom("MarkerFelt-Thin", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .shadow(color: .white.opacity(0.7), radius: 2, x: 1, y: 1)
                    
                    TextAnimationScore(text: score,
                                       trigger: false,
                                       speed: 0.06)
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.black)
                    .shadow(color: .white.opacity(0.3), radius: 2, x: 1, y: 1)
                    Spacer()
                }
                .padding(.trailing)
                //Time
                HStack(alignment: .bottom) {
                    Spacer()
                    Text("Time board: ")
                        .font(.custom("MarkerFelt-Thin", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
     
                    TextAnimationScore(text: time,
                                       trigger: false,
                                       speed: 0.06)
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                    Spacer()
                }
                .padding(.bottom, -5)
                
                MiddleLine(newLineWidth: 250)
                //Total
                HStack {
                    let totalScore = heroData.playerScore + heroData.gameTime
                    let textTotalScore = String(totalScore)
                    
                    Text("TOTAL: ")
                        .font(.custom("MarkerFelt-Thin", size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .shadow(color: .white.opacity(0.8), radius: 4, x: 2, y: 2)
                    
                    
                    TextAnimationScore(text: textTotalScore,
                                       trigger: false,
                                       speed: 0.06)
                    .font(.system(.largeTitle, design: .monospaced))
                    .foregroundColor(.red)
                }
                Spacer()
                
            }
            //Restart
            HStack {
                RestartButtonView(symbolName: "globe", action: {
                    presentContentView()
                })
                .padding(.all, 10)
            }
            .offset(x: 0, y: 105)
            
        }
    }
    
    private func presentContentView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let contentView = ContentView()
        let hostController = UIHostingController(rootView: contentView)
        let navController = UINavigationController(rootViewController: hostController)
        window.rootViewController = navController
        heroData.isDisabled = false
    }
}

#Preview {
    ScoreBoardView()
}
