//
//  SkillDetailView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 22.07.2024.
//
//
import SwiftUI

struct SkillTreeScreen: View {
    @StateObject private var skillTreeManager = SkillTreeManager()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                TabView {
                    SkillBranchView(branch: .economy)
                        .tabItem {
                            Label("Economy", systemImage: "dollarsign.circle")
                        }
                    SkillBranchView(branch: .army)
                        .tabItem {
                            Label("Army", systemImage: "shield")
                        }
                }
                
                Spacer()
                VStack {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        ReturnButton(symbolName: "globe", action: {
                            presentContentView()
                        })
                        .frame(width: 80, height: 80)
                        .position(x: geometry.size.width - 40, y: 40)
                    } else {
                        ReturnButton(symbolName: "globe", action: {
                            presentContentView()
                        })
                        .frame(width: 60, height: 60)
                        .position(x: geometry.size.width, y: 40)
                    }
                }

            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(skillTreeManager)
        .onAppear {
            skillTreeManager.loadSkills()
        }
    }
    
    
    private func presentContentView() {
        let mapModel = CountryDataManager.shared
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let contentView = ContentView()
        let hostController = UIHostingController(rootView: contentView)
        let navController = UINavigationController(rootViewController: hostController)
        window.rootViewController = navController
//                heroData.isDisabled = false
                mapModel.updateCountryBackgroundColor(playerPower: HeroData.shared.playerPower)
    }
}
