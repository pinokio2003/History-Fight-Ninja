//
//  ContentView.swift
//  SkillTree
//
//  Created by Anatolii Kravchuk on 19.07.2024.
//

import SwiftUI

struct SkillTreeView: View {
    
    @State private var selectedTab: Int = 0
    let tabs = ["Economic", "Army", "Diplomacy"]
    let backgroundImages = ["economyBackground", "armyBackground", "dyplomacyBackground"]
    
    var body: some View {
        
        GeometryReader { geometry in
                ZStack {
                    Image(backgroundImages[selectedTab])
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .blur(radius: 1)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
                VStack {
                    
                    HStack(spacing: 2) {
                        ForEach(0..<tabs.count, id: \.self) { index in
                            Spacer()
                            Button {
                                selectedTab = index
                            } label: {
                                Text(tabs[index])
                                    .font(.custom("Chalkduster", size: 20))
//                                    .fixedSize(horizontal: false, vertical: false)
                                    .frame(width: geometry.size.width / 4.5,
                                           height: geometry.size.height / 10)
                                    .background(selectedTab == index ? Color.blue.opacity(0.9) : Color.gray.opacity(0.9))
                                    .foregroundColor(selectedTab == index ? .red : .white)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(selectedTab == index ? .red : .black, lineWidth: 2)
                                    }
                                
                            }
                            .cornerRadius(15)
                            .padding(.leading)
                            
                        }
                        Spacer()
                        ReturnButton(symbolName: "globe", action: {
                            presentContentView()
                        })
                        .frame(width: 40, height: 40)
                    }
//                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity)
                        VStack {
                            switch selectedTab {
                                case 0:
                                    EconomySkillTreeView()
                                case 1:
                                    ArmySkillTreeView()
                                case 2:
                                    Text("Diplomacy")
                                default:
                                    Text("No 4-th tab")
                            }
                        }
                }
        }
        .edgesIgnoringSafeArea(.leading)
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

#Preview {
    SkillTreeView()
}
