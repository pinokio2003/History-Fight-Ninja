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
                    .frame(height: UIScreen.main.bounds.height, alignment: .top)
                    Spacer()
                    Text("Menu button")
                        .padding(.top, 20)
                        .frame(height: UIScreen.main.bounds.height, alignment: .top)
                }
            }
            
            if heroData.isFightStartButton {
                SpriteView(scene: game!)
                    .ignoresSafeArea()
            }
        }
        .environmentObject(heroData)
        .environmentObject(mapsDict)
        .onDisappear {
            heroData.isFightStartButton = false
        }
    }
}



//#Preview {
//    ContentView(isSelected: false)
//}
