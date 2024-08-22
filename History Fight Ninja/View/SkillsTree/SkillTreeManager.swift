//
//  SkillTreeManager.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 15.08.2024.
//

import SwiftUI

class SkillTreeManager: ObservableObject {
    static let sharedSkillTreeManager = SkillTreeManager()
    
    @Published var economySkills: [Skill] = [] {
        didSet {
            saveSkills()
        }
    }
    @Published var armySkills: [Skill] = [] {
        didSet {
            saveSkills()
        }
    }
    @Published var resources: Int = 100
    
    private let economySkillsKey = "economySkills"
    private let armySkillsKey = "armySkills"
    
    init() {
        loadSkills()
    }
    
    func saveSkills() {
        // Сохраняем массив `economySkills` в `UserDefaults`
        if let encodedEconomy = try? JSONEncoder().encode(economySkills),
           let encodedArmy = try? JSONEncoder().encode(armySkills) {
            UserDefaults.standard.set(encodedEconomy, forKey: economySkillsKey)
            UserDefaults.standard.set(encodedArmy, forKey: armySkillsKey)
        }
        // Сохраняем массив `armySkills` в `UserDefaults`
        print("Скиллы сохранены")
    }
     
    func loadSkills() {
        // Загружаем массив `economySkills` из `UserDefaults`
        if let savedEconomyData = UserDefaults.standard.data(forKey: economySkillsKey),
           let decodedEconomySkills = try? JSONDecoder().decode([Skill].self, from: savedEconomyData),
           let savedArmyData = UserDefaults.standard.data(forKey: armySkillsKey),
           let decodedArmySkills = try? JSONDecoder().decode([Skill].self, from: savedArmyData)
        
        {
            economySkills = decodedEconomySkills
            armySkills = decodedArmySkills
            print("Экономические скиллы загружены")
            print("Армейские скиллы загружены")
        } else {
            economySkills = defaultEconomySkills(manager: self)
            armySkills = defaultArmySkills(manager: self)
            print("Армейские скиллы по умолчанию загружены")
            print("Экономические скиллы по умолчанию загружены")
        }
        updateUnlockedSkills()
    }
    
    func resetSkills() {
        economySkills = defaultEconomySkills(manager: self)
        armySkills = defaultArmySkills(manager: self)
        saveSkills()
        resources = 100 // Сбрасываем количество ресурсов (если нужно)
        updateUnlockedSkills()
    }
    

    func increaseIncome() {
        print("Доход увеличен")
        // Логика увеличения дохода
    }
    
    func increaseArmyStrength() {
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
