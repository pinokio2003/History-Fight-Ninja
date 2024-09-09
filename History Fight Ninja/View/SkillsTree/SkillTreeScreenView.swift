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
                    SkillBranchView(branch: .economy, backgroundImageName: "economyBackground")
                        .tabItem {
                            Label("Экономика", systemImage: "dollarsign.circle")
                        }
                    SkillBranchView(branch: .army, backgroundImageName: "armyBackground")
                        .tabItem {
                            Label("Армия", systemImage: "shield")
                        }
                }
                    ReturnButton(symbolName: "globe", action: {
                            presentContentView()
                        })
                        .position(x: geometry.size.width - 64 , y: geometry.size.height * 0.01)
                        .padding(.leading)
            }
        }
        .environmentObject(skillTreeManager)
        .onAppear {
            skillTreeManager.loadSkills()
        }
    }
    private func presentContentView() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let contentView = ContentView()
        let hostController = UIHostingController(rootView: contentView)
        let navController = UINavigationController(rootViewController: hostController)
        window.rootViewController = navController
//        heroData.isDisabled = false
    }
}
