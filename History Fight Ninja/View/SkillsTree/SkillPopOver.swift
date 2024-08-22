//
//  SkillPopOver.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 16.08.2024.
//

import SwiftUI

struct SkillPopover: View {
    @EnvironmentObject var skillTreeManager: SkillTreeManager
    @StateObject var heroData = HeroData.shared
    
    let skill: Skill
    @Binding var isPresented: Bool
    @State private var isImageLoaded = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                Image(skill.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: geometry.size.height * 0.5)
                    .cornerRadius(10)
                    .padding(.top)
                    .onAppear { withAnimation(.easeIn(duration: 0.5)) { isImageLoaded = true } }
                    .opacity(isImageLoaded ? 1 : 0)
                    .shadow(color: .blue.opacity(0.9), radius: 9, x: 2, y: 2)
          
                
                Divider()
                    .padding(.vertical)
                
                Text(skill.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text(skill.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if !skill.isPurchased && heroData.playerExperience >= skill.cost {
                    Button(action: {
                        skillTreeManager.purchaseSkill(skill.id, branch: skill.branch)
                        skillTreeManager.saveSkills()
                        isPresented = false
                        heroData.playerExperience = heroData.playerExperience - skill.cost
                    }) {
                        Text("Buy: \(skill.cost)")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(skill.isUnlocked ? Color.blue : Color.gray)
                            .cornerRadius(10)
                    }
                    .disabled(!skill.isUnlocked)
                    .padding(.horizontal)
                } else {
                    Text(heroData.playerExperience <= skill.cost ? "Need \(skill.cost)" : "Умение уже приобретено")
                        .foregroundColor(.green)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .padding()
            .frame(width: min(geometry.size.width * 0.9, 300))
            .background(Color(UIColor.systemBackground))
            .cornerRadius(20)
            .shadow(radius: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blue.opacity(0.3), lineWidth: 2)
            )
            .overlay(
                Button(action: { isPresented = false }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title)
                        .overlay(
                            RoundedRectangle(cornerRadius: 50)
                                .stroke(Color.gray.opacity(0.7), lineWidth: 2)
                        )
                }
                .padding(),
                alignment: .topTrailing
            )
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
        .background(
           Color(red: 7/255, green: 1/255, blue: 47/255)
        )
    }
}
