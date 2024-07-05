//
//  ScoreBoardView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 27.06.2024.
//

import SwiftUI

struct ScoreBoardView: View {
    private let heroData = HeroData.shared
    
    @State var isShowingWinText: Bool = false
    @State var isShowingScoreText: Bool = false
    @State var isShowingTimeText: Bool = false
    @State var isShowingTotalScoreText: Bool = false
    
    var body: some View {
        let time = String(heroData.gameTime)
        let score = String(heroData.playerScore)
        
        ZStack {
            CustomBackground()
                .background(.quaternary)
            
            VStack {
                if isShowingWinText {
                    //Winning text
                    Text("YOU WIN !!!")
                        .font(.custom("MarkerFelt-Thin", size: 60))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                        .padding(.top, 10)
                }
                //Score
                if isShowingScoreText {
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
                        .transition(.scale)
                        Spacer()
                    }
                    .padding(.trailing)
                }
                //Time
                if isShowingTimeText {
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
                    .transition(.scale)
                    
                    MiddleLine(newLineWidth: 250)
                    
                }
                if isShowingTotalScoreText {
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
                        .foregroundColor(.black)
                        .transition(.scale)
                    }
                    Spacer()
                    
                }
                
            }
            //Restart button
            if isShowingTotalScoreText {
                HStack {
                    RestartButtonView(symbolName: "globe", action: {
                        presentContentView()
                    })
                    .padding(.all, 10)
                }
                .offset(x: 0, y: 105)
            }
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                isShowingWinText = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                withAnimation(.easeIn(duration: 0.5)) {
                    isShowingScoreText = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                withAnimation(.easeIn(duration: 0.5)) {
                    isShowingTimeText = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
                withAnimation(.easeIn(duration: 0.5)) {
                    isShowingTotalScoreText = true
                }
            }
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
