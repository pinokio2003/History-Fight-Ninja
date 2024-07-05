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
        ZStack {
            LinearGradient(colors: [first, second],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing) // background
            .background(.quaternary)
            VStack {
                
                Text("YOU LOSE BATTLE")
                    .font(.custom("MarkerFelt-Thin", size: 50))
                   
                    .foregroundColor(.red)
                    .opacity(isVisible ? 1 : 0.1)
                    .animation(.easeInOut(duration: 2), value: isVisible)
                    .onAppear {
                        withAnimation {
                            self.isVisible.toggle()
                        }
                    }
                
                Text("BUT NOT A WAR")
                    .font(.custom("MarkerFelt-Thin", size: 40))
                    .foregroundColor(.red)
                    .opacity(isVisible ? 1 : 0.1)
                    .animation(.easeIn(duration: 4), value: isVisible)
    
                
                HStack {
                    Spacer()
                    RestartButtonView(symbolName: "arrow.clockwise", action: {
                        restartGame()
                       })
                                   
                    Spacer()
                    
                    RestartButtonView(symbolName: "globe", action: {
                        presentContentView()
                        
                    })

                    Spacer()
                }
            }
            
            if heroData.isRestartPushing, let game = game {
                SpriteView(scene: game)
                    .ignoresSafeArea()
            }
        }
        .disabled(heroData.isDisabled)
        .background(
            Color.black
        )
        .environmentObject(heroData)
        .ignoresSafeArea()
        .onDisappear {
            game = nil
        }
    }
    
    private func restartGame() {
        heroData.isRestartPushing.toggle()
        if heroData.isRestartPushing {
            game = GameScene(fileNamed: "game")
        } else {
            game = nil
        }
        heroData.isDisabled = false
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
    GameOvewView()
}
