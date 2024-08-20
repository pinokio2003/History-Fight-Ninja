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
        print("Сохранено")
    }
    
    func loadSkills() {
        // Загружаем массив `economySkills` из `UserDefaults`
        if let savedData = UserDefaults.standard.data(forKey: economySkillsKey),
           let decodedSkills = try? JSONDecoder().decode([Skill].self, from: savedData) {
            economySkills = decodedSkills
            print("Загружено")
        } else {
            economySkills = defaultEconomySkills(manager: self) // Загружаем начальные данные, если ничего не сохранено
            print("Ничего не загружено")
        }
        
        updateUnlockedSkills()
    }
    
    func resetSkills() {
        economySkills = defaultEconomySkills(manager: self)
        saveSkills()
        resources = 100 // Сбрасываем количество ресурсов (если нужно)
        updateUnlockedSkills()
    }
    

    func increaseIncome() {
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
