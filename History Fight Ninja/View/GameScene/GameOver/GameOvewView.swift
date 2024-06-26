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
    @State var isRestart: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
            HStack {
                Button(action: {
                    heroData.isRestartPushing.toggle()
                    print(heroData.isRestartPushing)
                    
                }, label: {
                    Text("Button restart")
                })
                .padding()
                
                Button(action: {
                }, label: {
                    Text("World Map")
                })
                .padding()
            }
            
            if heroData.isRestartPushing {
                let game = GameScene(fileNamed: "game")
                SpriteView(scene: game!)
                    .ignoresSafeArea()
            }
        }
        .environmentObject(heroData)
        .ignoresSafeArea()
    }
}

#Preview {
    GameOvewView()
}
