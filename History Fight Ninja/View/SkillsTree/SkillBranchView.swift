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
    let backgroundImageName: String
    let imageCache = NSCache<NSString, UIImage>()
    // Настраиваемые размеры контента (можно изменять по необходимости)
    let contentWidth: CGFloat = 1000  // Ширина контента
    let contentHeight: CGFloat = 2000 // Высота контента
    
    var skills: [Skill] {
        skillTreeManager.getSkillsForBranch(branch)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
// Content:
                ScrollView([.horizontal, .vertical]) {
                    ZStack {
                        // Связи между умениями
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
// Skills:
                        ForEach(skills) { skill in
                            SkillView(skillId: skill.id, branch: branch, cache: imageCache)
                                .position(position(for: skill))
                        }
                    }
                    .frame(width: contentWidth, height: contentHeight)
                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .background(
               Color(red: 7/255, green: 1/255, blue: 47/255)
//                Image("economyBackground")
//                    .resizable()
//                    .scaledToFill()
//                    .edgesIgnoringSafeArea(.all)

            )
        }
    }
    
    func position(for skill: Skill) -> CGPoint {
        CGPoint(x: skill.position.x * contentWidth,
                y: skill.position.y * contentHeight)
    }
}
