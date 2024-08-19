//
//  SkillTreeManager.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 15.08.2024.
//

import Foundation
import SwiftUI

import SwiftUI

class SkillTreeManager: ObservableObject {
    static let sharedSkillTreeManager = SkillTreeManager()
    
    @Published var economySkills: [Skill] = [] {
        didSet {
            saveSkills()
        }
    }
    @Published var armySkills: [Skill] = []
    @Published var resources: Int = 100
    
    private let economySkillsKey = "economySkills"
    
    init() {
        loadSkills()
    }
    
    func saveSkills() {
        // Сохраняем массив `economySkills` в `UserDefaults`
        if let encoded = try? JSONEncoder().encode(economySkills) {
            UserDefaults.standard.set(encoded, forKey: economySkillsKey)
        }
    }
    
    func loadSkills() {
        // Загружаем массив `economySkills` из `UserDefaults`
        if let savedData = UserDefaults.standard.data(forKey: economySkillsKey),
           let decodedSkills = try? JSONDecoder().decode([Skill].self, from: savedData) {
            economySkills = decodedSkills
        } else {
            economySkills = defaultEconomySkills() // Загружаем начальные данные, если ничего не сохранено
        }
        
        updateUnlockedSkills()
    }
    
    func resetSkills() {
        economySkills = defaultEconomySkills()
        saveSkills()
        resources = 100 // Сбрасываем количество ресурсов (если нужно)
        updateUnlockedSkills()
    }
    
    private func defaultEconomySkills() -> [Skill] {
        let economySkill1 = UUID()
        let economySkill2 = UUID()
        let economySkill3 = UUID()
        let economySkill4 = UUID()
        let economySkill5 = UUID()
        let economySkill6 = UUID()
        let economySkill7 = UUID()
        let economySkill8 = UUID()
        
        return [
            Skill(id: economySkill1, name: "Экономика 1", description: "add something", branch: .economy, isUnlocked: true, isPurchased: false, imageName: "EconomcBasicsAutomation", action: { self.increaseIncome() }, dependencies: [], position: CGPoint(x: 0.45, y: 0.01)),
            Skill(id: economySkill2, name: "Экономика 2", description: "add something", branch: .economy, isUnlocked: false, isPurchased: false, imageName: "ManufacturingBasics", action: { self.increaseIncome() }, dependencies: [economySkill1], position: CGPoint(x: 0.1, y: 0.1)),
            Skill(id: economySkill3, name: "Экономика 3", description: "add something", branch: .economy, isUnlocked: true, isPurchased: false, imageName: "EconomcBasicsAutomation", action: { self.increaseIncome() }, dependencies: [economySkill1], position: CGPoint(x: 0.45, y: 0.1)),
            Skill(id: economySkill4, name: "Экономика 4", description: "add something", branch: .economy, isUnlocked: false, isPurchased: false, imageName: "ModernTechnologies", action: { self.increaseIncome() }, dependencies: [economySkill1], position: CGPoint(x: 0.7, y: 0.1)),
            Skill(id: economySkill5, name: "Экономика 5", description: "add something", branch: .economy, isUnlocked: true, isPurchased: false, imageName: "SavingResources", action: { self.increaseIncome() }, dependencies: [economySkill4], position: CGPoint(x: 0.55, y: 0.2)),
            Skill(id: economySkill6, name: "Экономика 6", description: "add something", branch: .economy, isUnlocked: false, isPurchased: false, imageName: "Innovation", action: { self.increaseIncome() }, dependencies: [economySkill4], position: CGPoint(x: 0.7, y: 0.2)),
            Skill(id: economySkill7, name: "Экономика 7", description: "add something", branch: .economy, isUnlocked: true, isPurchased: false, imageName: "Robotization", action: { self.increaseIncome() }, dependencies: [economySkill4], position: CGPoint(x: 0.85, y: 0.2)),
            Skill(id: economySkill8, name: "Экономика 8", description: "add something", branch: .economy, isUnlocked: false, isPurchased: false, imageName: "Internationalization", action: { self.increaseIncome() }, dependencies: [economySkill7, economySkill5], position: CGPoint(x: 0.7, y: 0.4)),
        ]
    }
    
    private func increaseIncome() {
        print("Доход увеличен")
        // Логика увеличения дохода
    }
    
    private func increaseArmyStrength() {
        print("added strength")
    }
    
    func purchaseSkill(_ skillId: UUID, branch: SkillBranch) {
        let skills = getSkillsForBranch(branch)
        guard let index = skills.firstIndex(where: { $0.id == skillId }) else { return }
        
        if skills[index].isUnlocked && !skills[index].isPurchased && resources >= 10 {
            var updatedSkill = skills[index]
            updatedSkill.isPurchased = true
            resources -= 10
            updatedSkill.action()
            
            updateSkill(updatedSkill, in: branch)
            updateUnlockedSkills()
            objectWillChange.send()
        }
    }
    
    private func updateSkill(_ skill: Skill, in branch: SkillBranch) {
        switch branch {
        case .economy:
            if let index = economySkills.firstIndex(where: { $0.id == skill.id }) {
                economySkills[index] = skill
            }
        case .army:
            if let index = armySkills.firstIndex(where: { $0.id == skill.id }) {
                armySkills[index] = skill
            }
        }
    }
    
    func getSkillsForBranch(_ branch: SkillBranch) -> [Skill] {
        switch branch {
        case .economy:
            return economySkills
        case .army:
            return armySkills
        }
    }
    
    private func updateUnlockedSkills() {
        updateBranchUnlockedSkills(.economy)
        updateBranchUnlockedSkills(.army)
    }
    
    private func updateBranchUnlockedSkills(_ branch: SkillBranch) {
        var skills = getSkillsForBranch(branch)
        for i in 0..<skills.count {
            skills[i].isUnlocked = canUnlock(skills[i], in: skills)
        }
        
        switch branch {
        case .economy:
            economySkills = skills
        case .army:
            armySkills = skills
        }
    }
    
    private func canUnlock(_ skill: Skill, in skills: [Skill]) -> Bool {
        return skill.dependencies.allSatisfy { dependencyId in
            skills.first(where: { $0.id == dependencyId })?.isPurchased == true
        }
    }
}
