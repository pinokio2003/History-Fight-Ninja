//
//  ContentView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 28.03.2024.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var heroData = HeroData()
    @StateObject var mapsDict = MapsModelData()
    let startScene = StartScene(fileNamed: "Start")!
//    let startScene = MapScene(fileNamed: "map")!
    
    var body: some View {
//        SpriteView(scene: startScene)
        HStack {
//            if heroData.isSelected {
//                SideMapView()
//                    .frame(width: 50)
//                    .transition(.slide.animation(.easeInOut(duration: 1.3)))
//            }
            WorldMapView()
//                .ignoresSafeArea()
        }
        .environmentObject(heroData)
        .environmentObject(mapsDict)
    }
}

//#Preview {
//    ContentView(isSelected: false)
//}
