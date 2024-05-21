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
        ZStack(alignment: .leading) {
            WorldMapView()
                .environmentObject(heroData)
        
                HStack() {
              
                    if heroData.isSelected {
                        SideMapView()
                    
                }
            }

//            .padding(.leading, 20)
            .environmentObject(heroData)
            .environmentObject(mapsDict)
        }

    }
}

//#Preview {
//    ContentView(isSelected: false)
//}
