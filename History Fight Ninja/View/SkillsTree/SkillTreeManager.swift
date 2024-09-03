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
    
    @Published var priceCoefficient: Double = 1 {
        didSet {
            savePriceCoefficient()
            updateSkillCosts()
        }
    }
    
    private let economySkillsKey = "economySkills"
    private let armySkillsKey = "armySkills"
    private let priceCoefficientKey = "priceCoefficient"
    
    init() {
        loadSkills()
        loadPriceCoefficient()
    }
 //MARK: - UserDefaults save and load
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
    
//price coefficient
    func savePriceCoefficient() {
        UserDefaults.standard.set(priceCoefficient, forKey: priceCoefficientKey)
    }

    private func loadPriceCoefficient() {
        if let savedCoefficient = UserDefaults.standard.value(forKey: priceCoefficientKey) as? Double {
            priceCoefficient = savedCoefficient
            print("Price coefficient loaded: \(priceCoefficient)")
        }
    }
    
//reset all skills
    func resetSkills() {
        economySkills = defaultEconomySkills(manager: self)
        armySkills = defaultArmySkills(manager: self)
        priceCoefficient = 1 // Reset the price coefficient to its default value
        saveSkills()
        savePriceCoefficient() // Save the reset price coefficient
        updateUnlockedSkills()
    }
    
//MARK: - purchaseSkill
    
    func purchaseSkill(_ skillId: UUID, branch: SkillBranch) {
        var skills = getSkillsForBranch(branch)
        guard let index = skills.firstIndex(where: { $0.id == skillId }) else { return }
        
        if skills[index].isUnlocked && !skills[index].isPurchased {
            skills[index].isPurchased = true
            
            // Выполняем действие навыка
            executeSkillAction(skills[index].actionKey)
            
            updateSkill(skills[index], in: branch)
            updateUnlockedSkills()
            objectWillChange.send()
            saveSkills()
        }
    }

//SKills actions case:
    private func executeSkillAction(_ actionKey: String) {
        switch actionKey {
        //income:
        case "increaseIncomeBy5":
            increaseIncome(5)
            print("Economic skill purchased: Income increased by 5")
        case "increaseIncomeBy3":
            increaseIncome(3)
            print("Economic skill purchased: Income increased by 5")
        //reduce costs:
        case "reduceCostsBy5":
            increasePriceCoefficient(value: 5)
            print("Skill reduced costs by 5%")
        case "reduceCostsBy2":
            increasePriceCoefficient(value: 2)
            print("Skill reduced costs by 2%")
        case "reduceCostsBy3":
            increasePriceCoefficient(value: 3)
            print("Skill reduced costs by 3%")
        //add energy:
        case "increaseEnergy1":
            increaseMaxEnergy(1)
        case "increaseEnergy3":
                increaseMaxEnergy(3)
        default:
            print("Unknown action: \(actionKey)")
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
    
    //MARK: - skill actions:
    func increaseIncome(_ income: Int) {
        HeroData.shared.playerIncome += income
            print("income: \(HeroData.shared.playerIncome)")
        }
        
    func increaseEconomyStrength() {
            print("added strength")
        }
        
    func increasePriceCoefficient(value: Int) {
        priceCoefficient = priceCoefficient - (Double(value) / 100.0)
        print("new price coefficient: \(priceCoefficient)")
    }
    
    func increaseMaxEnergy(_ energy: Int) {
        HeroData.shared.playerEnergyMax += energy
        print("added max energy + \(energy), now max energy = \(HeroData.shared.playerEnergyMax)")
    }
    
//MARK: Other functions
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
    private func updateSkillCosts() {
        updateBranchSkillCosts(.economy)
        updateBranchSkillCosts(.army)
    }

//for cost skills update
    private func updateBranchSkillCosts(_ branch: SkillBranch) {
        var skills = getSkillsForBranch(branch)
        for i in 0..<skills.count {
            skills[i].cost = Int(Double(skills[i].baseCost) * priceCoefficient)
            print("new skill \(skills[i].name) cost: \(skills[i].cost)")
        }
        
        switch branch {
        case .economy:
            economySkills = skills
        case .army:
            armySkills = skills
        }
    }
//unlock:
    private func canUnlock(_ skill: Skill, in skills: [Skill]) -> Bool {
        return skill.dependencies.allSatisfy { dependencyId in
            skills.first(where: { $0.id == dependencyId })?.isPurchased == true
        }
    }
}
