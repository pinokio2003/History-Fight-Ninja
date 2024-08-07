//
//  SkillView.swift
//  SkillTree
//
//  Created by Anatolii Kravchuk on 19.07.2024.
//

import SwiftUI

struct SkillView: View {
    var skill: SkillModel
    var size: CGFloat
    @Binding var unlockedSkills: Set<UUID>
    @State private var isShowingPopover = false
    
    private var skillState: SkillState {
        if unlockedSkills.contains(skill.id) {
            return .unlocked
        } else if skill.isAviable && skill.requiredSkill.allSatisfy({ unlockedSkills.contains($0) }) {
            return .available
        } else {
            return .locked
        }
    }
    
    var body: some View {
        ZStack {
            skill.image()
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .opacity(skillState == .locked ? 0.5 : 1.0)
                .cornerRadius(15)
        }
        .padding(.all, 5)
        .background(backgroundColorForState(skillState))
        .cornerRadius(25)
        .shadow(color: .black, radius: 1, x: 3, y: 2)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(borderColorForState(skillState), lineWidth: 1)
        }
        .onTapGesture {
            if skillState != .locked {
                isShowingPopover = true
            }
        }
        .popover(isPresented: $isShowingPopover, arrowEdge: .top) {
            SkillPopoverView(skill: skill, isPresented: $isShowingPopover, canUnlock: skillState == .available, onUnlock: {
                if skillState == .available {
                    unlockedSkills.insert(skill.id)
                }
            })
        }
        .onDisappear {
            ImageCache.shared.clearCache()
        }
    }
    
    private func backgroundColorForState(_ state: SkillState) -> Color {
        switch state {
        case .unlocked:
            return Color.green.opacity(0.7)
        case .available:
            return Color.blue.opacity(0.7)
        case .locked:
            return Color.gray.opacity(0.9)
        }
    }
    
    private func borderColorForState(_ state: SkillState) -> Color {
        switch state {
        case .unlocked:
            return Color.green
        case .available:
            return Color.blue
        case .locked:
            return Color.black
        }
    }
}

enum SkillState {
    case unlocked, available, locked
}

struct SkillView_Previews: PreviewProvider {
    static var previews: some View {
        SkillView(
            skill: exampleSkill,
            size: 100,
            unlockedSkills: .constant([]) // Используем .constant для @Binding в Preview
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
