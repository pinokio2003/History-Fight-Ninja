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
   
    var body: some View {
        ZStack {
            Image("MenuBG1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                StartButton(action: {
                    heroData.clearUserDefaults()
                    presentPickContetntView()
                },
                            text: "NEW GAME",
                            isUpBubble: true)
                .frame(width: 250, height: 50, alignment: .center)
                
                StartButton(action: {
                    print("OK")
                },
                            text: "CONTINUE",
                            isUpBubble: false)
                .frame(width: 250, height: 50, alignment: .center)
                .padding(.bottom, 15)
            }
        }
    }
    
    private func fadeIn() {
           withAnimation(.easeIn(duration: 0.5)) {
               transitionState.opacity = 1.0
           }
       }
       
       private func fadeOutAndPresentPickContentView() {
           withAnimation(.easeOut(duration: 0.5)) {
               transitionState.opacity = 0.0
           }
           
           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
               presentPickContetntView()
           }
       }
    
    private func presentPickContetntView()  {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let contentView = PickContetntView()
        let hostController = UIHostingController(rootView: contentView)
        let navController = UINavigationController(rootViewController: hostController)
        navController.setNavigationBarHidden(true, animated: false)
        
        UIView.animate(withDuration: 0.5, animations: {
            window.alpha = 0
        }) { _ in
            window.rootViewController = navController
            UIView.animate(withDuration: 0.5) {
                window.alpha = 1
            }
        }
    }
}

