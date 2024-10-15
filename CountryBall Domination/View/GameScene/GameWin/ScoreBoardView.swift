//
//  ScoreBoardView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 27.06.2024.
//

import SwiftUI

struct ScoreBoardView: View {
    private let heroData = HeroData.shared
    
    @State private var isShowingWinText: Bool = false
    @State private var isShowingScoreText: Bool = false
    @State private var isShowingTimeText: Bool = false
    @State private var isShowingIncomeText: Bool = false
    @State private var isShowingTotalScoreText: Bool = false
    @State private var isShowingButton: Bool = false
    
    
    var body: some View {
        let time = String(heroData.gameTime)
        let score = String(heroData.playerScore)
        let income = String(heroData.playerIncome)
        let totalScore = heroData.playerScore + heroData.gameTime + heroData.playerIncome
        let prizeScore = String(totalScore * heroData.prizeVictory / 100)
        
        GeometryReader { geometry in
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
                            //                        Spacer()
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
                            //                        Spacer()
                            
                            
                        }
                        .padding(.trailing)
                    }
                    //Time
                    if isShowingTimeText {
                        HStack(alignment: .bottom) {
                            //                        Spacer()
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
                            //                        Spacer()
                        }
                        .padding(.trailing)
                    }
                    
                    if isShowingIncomeText {
                        HStack(alignment: .bottom) {
                            //                        Spacer()
                            Text("Income: ")
                                .font(.custom("MarkerFelt-Thin", size: 30))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                            
                            TextAnimationScore(text: income,
                                               trigger: false,
                                               speed: 0.06)
                            .font(.system(.largeTitle, design: .monospaced))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 2, x: 1, y: 1)
                            //                        Spacer()
                        }
                        .padding(.bottom, -5)
                        .transition(.scale)
                        MiddleLine(newLineWidth: 250)
                        
                    }
                    
                    if isShowingTotalScoreText {
                        //Total
                        HStack {
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
                            
                            if heroData.prizeVictory != 0 {
                                Text("+ prize: \(prizeScore)")
                                    .font(.custom("MarkerFelt-Thin", size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .shadow(color: .white.opacity(0.8), radius: 4, x: 2, y: 2)
                            }
                        }
                        Spacer()
                    }
                    
                }
                //Restart button
                //                if isShowingTotalScoreText {
                VStack {
                    Spacer()
                    HStack {

                        RestartButtonView(symbolName: "globe", action: {
                            heroData.playerExperience += totalScore + (totalScore * heroData.prizeVictory / 100)
                            heroData.isDisabled = false
                            presentContentView(with: ContentView())
                        },
                                          sizeValue: geometry.size.width / 35)
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
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
                        isShowingIncomeText = true
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.8) {
                    withAnimation(.easeIn(duration: 0.5)) {
                        isShowingTotalScoreText = true
                    }
                }
            }
        }
    }
}
