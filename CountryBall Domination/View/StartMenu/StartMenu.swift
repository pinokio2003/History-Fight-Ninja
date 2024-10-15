//
//  StartMenu.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 04.10.2024.
//

import SwiftUI

struct StartMenu: View {
    @StateObject private var transitionState = CountryDataManager.shared
    private let heroData = HeroData.shared
    private let mapModel = CountryDataManager.shared
    @State private var showAlert: Bool = false
    
    
    var body: some View {
        ZStack {
            Image("MenuBG1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                // Show buttons or alarm:
                if showAlert == false {
                    
                    StartButton(action: {
                        if heroData.isDataConsistent {
                            withAnimation(.spring(duration: 0.5, bounce: 0.45)) {
                                showAlert.toggle()
                            }
                        } else {
                            heroData.clearUserDefaults()
                            presentContentView(with: PickContetntView())
                        }
                    },
                                text: "NEW GAME",
                                isUpBubble: true)
                    .frame(width: 250, height: 50, alignment: .center)
                    .padding(.bottom, heroData.isDataConsistent ? 0 : 50)
                    // if user data consist
                    if heroData.isDataConsistent {
                        StartButton(action: {
                            presentContentView(with: ContentView())
                        },
                                    text: "CONTINUE",
                                    isUpBubble: false)
                        .frame(width: 250, height: 50, alignment: .center)
                        .padding(.bottom, 15)
                    }
                }

            }
            
            // CustomAlertView, который показывается, когда showAlert = true
            if showAlert {
                withAnimation(.spring(duration: 1.5, bounce: 0.45)) {
                    CustomAlertView(showAlert: $showAlert)
                        .frame(width: 300, height: 200, alignment: .center)
                        .padding(.top, 100)
                }
            }
        }
        .onAppear {
            mapModel.updateCountryBackgroundColor(playerPower: HeroData.shared.playerPower)
        }
    }
    
    private func fadeIn() {
        withAnimation(.easeIn(duration: 0.5)) {
            transitionState.opacity = 1.0
        }
    }
    
    func showAllertToggle() {
        withAnimation(.spring(duration: 0.5, bounce: 0.45)) {
            showAlert.toggle()
        }
    }
    
//    private func fadeOutAndPresentPickContentView(action: () -> Void) {
//        withAnimation(.easeOut(duration: 0.5)) {
//            transitionState.opacity = 0.0
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            presentPickContetntView()
//        }
//    }
    

}
