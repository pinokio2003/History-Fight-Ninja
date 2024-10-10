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
    @State var isInfoBarVisible = false

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

                if heroData.isMenuButtonPushed {
                    // InfoBarView
                    VStack {
                        if heroData.isCountrySelected != true {
                            InfoBarView(heroData: heroData)
                                .transition(.slide)
                        }
                        Spacer()
                    }

                    // MenuButtonView (separated for iPad and others)
                    HStack {
                        Spacer()
                        VStack {
                            if UIDevice.current.userInterfaceIdiom == .pad {
                                // iPad-specific layout
                                MenuButtonView()
                                    .frame(width: 80, height: 80)
                                    .position(x: geometry.size.width - 50, y: 120)
                            } else {
                                // Layout for other devices (iPhone)
                                MenuButtonView()
                                    .frame(width: 60, height: 60)
//                                    .padding(.bottom, 40)
//                                    .position(x: geometry.size.width - 80, y: 40)
                            }
                            Spacer()
                        }
//                        .padding(.top, 40)
                    }
                    .padding(.trailing, 40)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(heroData)
        .environmentObject(mapsDict)
        .onDisappear {
            heroData.isFightStartButton = false
        }
    }
}
