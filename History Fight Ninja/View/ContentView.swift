//
//  ContentView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 28.03.2024.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var heroData = HeroData.shared
    @StateObject var mapsDict = CountryDataManager()

    let game = GameScene(fileNamed: "game")
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack(alignment: .leading) {

                    
                    if !heroData.isFightStartButton {
                        WorldMapView()
                    }
                    
                    if heroData.isCountrySelected && !heroData.isFightStartButton {
                        HStack {
                            SideMapView()
                            Spacer()
                            
                            VStack {
                                CountryNameView()
                                    .padding(.top, 20)
                                Spacer()
                            }
                            .frame(height: geometry.size.height, alignment: .top)
                            Spacer()
                            SideMapRightView()
                                .animation(Animation.easeInOut(duration: 0.3), value: heroData.isAnimationBeforeFight)
                            Spacer()
                        }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                        
                    
                    if heroData.isFightStartButton {
                        SpriteView(scene: game!)
                            .ignoresSafeArea()
                    }
                    
                    if heroData.isAnimationBeforeFight {
                        MiddleVsText()
                            .offset(x: geometry.size.width * 0.4)
                            .animation(Animation.easeInOut(duration: 0.5), value: heroData.isAnimationBeforeFight)
                    }
                }
//                if !heroData.isAnimationBeforeFight {
                if heroData.isMenuButtonPushed {
                // MenuButton
                    MenuButtonView()
                        .frame(width: 60, height: 60)
                        .position(x: geometry.size.width - 40, y: geometry.size.height * 0.1)
                }
                //Player Experience
                HStack {
                    Text("Player Experience: \(heroData.playerExperience)")
                        .foregroundColor(Color.red)
                    
                    Text("Enery: \(heroData.playerEnergyMax)")
                        .foregroundColor(Color.red)
                    
                    Text("Income: \(heroData.playerIncome)")
                        .foregroundColor(Color.green)
                }
                    .position(x: geometry.size.width * 0.01 + 140, y: geometry.size.height * 0.1)
                    .padding(.leading)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(heroData)
        .environmentObject(mapsDict)
        .onDisappear {
            heroData.isFightStartButton = false
        }
    }
}
