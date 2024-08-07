//
//  ArmySkillTreeView.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 06.08.2024.
//

import SwiftUI

struct ArmySkillTreeView: View {
    @State private var unlockedSkills: Set<UUID> = []
    
    var body: some View {

        VStack {
            GeometryReader(content: { geometry in
                ScrollView(.horizontal) {
                    HStack() {
                        SkillView(skill: militarySklillTree, size: geometry.size.height / 2, unlockedSkills: $unlockedSkills)
                            .position(x: geometry.size.height / 4, y: geometry.size.height / 2)
                            .padding(.leading)
                        VStack() {
                            HStack {
                                ForEach(militarySkillArray) { skill in
                                    SkillView(skill: skill, size: geometry.size.height / 2.8,
                                              unlockedSkills: $unlockedSkills)
                                }
                            }
                            
                            HStack {
                                ForEach(militarySkillArray) { skill in
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
