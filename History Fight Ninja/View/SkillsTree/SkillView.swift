//
//  SkillView.swift
//  SkillTree
//
//  Created by Anatolii Kravchuk on 19.07.2024.
//

import SwiftUI

struct SkillView: View {
    @EnvironmentObject var skillTreeManager: SkillTreeManager
    let skillId: UUID
    let branch: SkillBranch
    let cache: NSCache<NSString, UIImage> 
    @State private var showPopover = false
    var skill: Skill {
        skillTreeManager.getSkillsForBranch(branch).first(where: { $0.id == skillId })!
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(
                    RadialGradient(gradient: Gradient(colors: [skill.isPurchased ? innerGreen : innerPurple, .clear]),
                                   center: .center,
                                   startRadius: 5,
                                   endRadius: 65)
                )
                .frame(width: 120, height: 120)
    
            VStack {
                CashedAssetImageSkills(imageName: skill.imageName, cache: cache)
                    .overlay(
                        RoundedRectangle(cornerRadius: 40)
                            .stroke(borderColor, lineWidth: 3)
                    )
                    .onTapGesture {
                            showPopover = true
                    }
            }
            .background(backgroundColor)
            .cornerRadius(40)
            .opacity(skill.isUnlocked ? 1.0 : 0.5)
            .sheet(isPresented: $showPopover) {
                SkillPopover(skill: skill, isPresented: $showPopover)
            }
        }
    }
    
    var borderColor: Color {
        if skill.isPurchased {
            return .green
        } else if skill.isUnlocked {
            return .red
        } else {
            return .gray
        }
    }
    
    var backgroundColor: Color {
        if skill.isPurchased {
            return Color.green.opacity(0.3)
        } else if skill.isUnlocked {
            return Color.red.opacity(0.3)
        } else {
            return Color.gray.opacity(0.9)
        }
    }
}
