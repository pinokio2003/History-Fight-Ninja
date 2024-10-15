//
//  GameOvewView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 11.06.2024.
//

import SwiftUI
import SpriteKit

struct GameOvewView: View {
    
    @ObservedObject var heroData = HeroData.shared
    @State private var isVisible: Bool = false
    @State private var game: GameScene? = nil

    //background gradient colors
    private let first: Color = Color(red: 43 / 255, green: 44 / 255, blue: 49 / 255)
    private let second: Color = Color(red: 56 / 255, green: 57 / 255, blue: 63 / 255)
    
    var body: some View {
        GeometryReader { geo in
        ZStack {
            Image("BackgroundGameOver")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(.quaternary)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            ZStack {

                VStack {
                    AnimationTableDefeat(width: geo.size.width / 3,
                                         height: geo.size.width / 3)
                    .padding(.top, -50)
                                    
                    Spacer()
//                        .padding(.bottom, 150)
                }

                
                VStack {
                    Spacer()
                   
                    HStack {
                        StartButton(action: {
                            presentGameScene()
                            heroData.isDisabled = false
                        }, text: "TRY AGAIN",
                                    isUpBubble: true)
                        .frame(width: 200, height: 70)
//                        .padding(.top, 40)
                        
                        StartButton(action: {
                            heroData.isDisabled = false
                            presentContentView(with: ContentView())
                            heroData.resetAllData()
                          
                        }, text: "TO MAP",
                                    isUpBubble: false)
                        .frame(width: 200, height: 70)
                       
                    }
//                    .padding(.top, geo.size.width / 3.5)
//                    Spacer()
                }
            }
            }
        .disabled(heroData.isDisabled)
        .environmentObject(heroData)
        .onDisappear {
            game = nil
        }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    GameOvewView()
}
