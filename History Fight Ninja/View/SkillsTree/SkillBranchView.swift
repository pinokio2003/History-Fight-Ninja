//
//  ContentView.swift
//  SkillTree
//
//  Created by Anatolii Kravchuk on 19.07.2024.
//

import SwiftUI

struct SkillBranchView: View {
    @EnvironmentObject var skillTreeManager: SkillTreeManager
    let branch: SkillBranch
    let imageCache = NSCache<NSString, UIImage>()
    let contentWidth: CGFloat = 1000
    let contentHeight: CGFloat = 2000
    
    var skills: [Skill] {
        skillTreeManager.getSkillsForBranch(branch)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView([.horizontal, .vertical]) {
                ScrollViewReader { scrollReader in
                    ZStack {
                        // Draw connections between skills
                        ForEach(skills) { skill in
                            ForEach(skill.dependencies, id: \.self) { dependencyId in
                                if let dependencySkill = skills.first(where: { $0.id == dependencyId }) {
                                    SkillConnectionView(
                                        from: position(for: dependencySkill),
                                        to: position(for: skill),
                                        offset: geometry.size.width * 0.01
                                    )
                                }
                            }
                        }
                        
                        // Display each skill in the correct position
                        ForEach(skills) { skill in
                            SkillView(skillId: skill.id, branch: branch, cache: imageCache)
                                .position(position(for: skill))
                                .id(skill.id) // Use skill ID to identify each view
                        }
                    }
                    .padding(.top, 50)
                    .frame(width: contentWidth, height: contentHeight)
                    .onAppear {
                        // Calculate the horizontal center point of the content
                        let centerX = (contentWidth - geometry.size.width) / 2
                        
                        // Find the skill closest to the horizontal center
                        if let centralSkill = skills.min(by: { skill1, skill2 in
                            abs(position(for: skill1).y - centerX) < abs(position(for: skill2).y - centerX)
                        }) {
                            // Scroll to the central skill
                            withAnimation {
                                scrollReader.scrollTo(centralSkill.id, anchor: .top)
                            }
                        }
                    }
                }
            }
            .background(Color(red: 7/255, green: 1/255, blue: 47/255))
        }
    }
    
    // Calculates the position of a skill within the content area
    func position(for skill: Skill) -> CGPoint {
        CGPoint(x: skill.position.x * contentWidth,
                y: skill.position.y * contentHeight)
    }
}
