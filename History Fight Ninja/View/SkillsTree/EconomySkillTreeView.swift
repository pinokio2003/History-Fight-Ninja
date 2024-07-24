//
//  EconomySkillTreeView.swift
//  SkillTree
//
//  Created by Anatolii Kravchuk on 19.07.2024.
//

import SwiftUI

struct EconomySkillTreeView: View {
    @State private var unlockedSkills: Set<UUID> = []
  
    var body: some View {

        VStack {
//            Text(rootSkill.name)
//                .font(.title)
//                .padding()
            GeometryReader(content: { geometry in
                ScrollView(.horizontal) {
                    HStack() {
                        SkillView(skill: economcSklillTree, size: geometry.size.height / 2, unlockedSkills: $unlockedSkills)
                            .position(x: geometry.size.height / 4, y: geometry.size.height / 2)
                            .padding(.leading)
                        VStack() {
                            HStack {
                                ForEach(ecnomicSkillArray) { skill in
                                    SkillView(skill: skill, size: geometry.size.height / 2.8,
                                              unlockedSkills: $unlockedSkills)
                                }
                            }
                            
                            HStack {
                                ForEach(tradingSkillArray) { skill in
                                    SkillView(skill: skill, size: geometry.size.height / 2.8,
                                              unlockedSkills: $unlockedSkills)
                                }
                            }
                        }
                    }
                }
//                .ignoresSafeArea()
            })
        }
        
    }
}

#Preview {
    SkillTreeView()
}
