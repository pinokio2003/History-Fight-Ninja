//
//  PlayerDataModel.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 09.05.2024.
//

import Foundation
import SwiftUI

class HeroData: ObservableObject {
    static let shared = HeroData()
    private let skillManager = SkillTreeManager.sharedSkillTreeManager
    
    @Published var name: String = "" // enemy
    @Published var isCountrySelected: Bool = false
    @Published var isFightStartButton: Bool = false
    @Published var isAnimationBeforeFight: Bool = false
    @Published var isRestartPushing: Bool = false
    @Published var isDisabled: Bool = false
    //For Score:
    @Published var gameTime: Int = 0
    @Published var playerScore: Int = 0
    
//MARK: - player info:
    @Published var playerCountry: String = UserDefaults.standard.string(forKey: "playerCountry") ?? "Ukraine" {
        didSet {
            UserDefaults.standard.set(playerCountry, forKey: "playerCountry")
        }
    }

    @Published var playerExperience: Int = UserDefaults.standard.integer(forKey: "playerExperience") { //UserDefaults.standard.integer(forKey: "playerExperience")
        didSet {
            UserDefaults.standard.set(playerExperience, forKey: "playerExperience")
        }
    }
 // % to prize after win battle
    @Published var prizeVictory: Int = UserDefaults.standard.integer(forKey: "prizeVictory") {
        didSet {
            UserDefaults.standard.set(prizeVictory, forKey: "prizeVictory")
        }
    }
    
    @Published var playerIncome: Int = {
        let key = "playerIncome"
        if UserDefaults.standard.object(forKey: key) == nil {
            return 1 // Return default value if key doesn't exist
        } else {
            return UserDefaults.standard.integer(forKey: key)
        }
        }() {
        didSet {
            UserDefaults.standard.set(playerIncome, forKey: "playerIncome")
        }
    }
    
    @Published var playerAttack: Int = UserDefaults.standard.integer(forKey: "playerAttack") {
        didSet {
            UserDefaults.standard.set(playerAttack, forKey: "playerAttack")
        }
    }
    
    @Published var playerHealth: Int = 100 {
        didSet {
            UserDefaults.standard.set(playerHealth, forKey: "playerHealth")
        }
    }
    
    @Published var playerEnergy: Int = UserDefaults.standard.integer(forKey: "playerEnergy") {
        didSet {
            UserDefaults.standard.set(playerEnergy, forKey: "playerEnergy")
        }
    }
        
    @Published var playerEnergyMax: Int = {
        let key = "playerEnergyMax"
        if UserDefaults.standard.object(forKey: key) == nil {
            return 5 // Return default value if key doesn't exist
        } else {
            return UserDefaults.standard.integer(forKey: key)
        }
    }() {
        didSet {
            UserDefaults.standard.set(playerEnergyMax, forKey: "playerEnergyMax")
        }
    }
    
    
//MARK: - other data
    @Published var enemyName: String = ""
//    @Published var allyArray: [String] = []
    //WorldMap menu button:
    @Published var isMenuButtonPushed: Bool = true
    
    private init() {}
    
    func resetAllData() {
        isCountrySelected = false
        isFightStartButton = false
        isRestartPushing = false
        isMenuButtonPushed = true
        enemyName = ""
    }
    
    func resetScoreAndTime() {
        gameTime = 0
        playerScore = 0
    }
    
    func clearUserDefaults() {
        skillManager.resetSkills()
        playerExperience = 6000
        playerEnergyMax = 5
        playerIncome = 5
        UserDefaults.standard.removeObject(forKey: "playerCountry")
        UserDefaults.standard.removeObject(forKey: "playerExperience")
        UserDefaults.standard.removeObject(forKey: "playerAttack")
        UserDefaults.standard.removeObject(forKey: "playerHealth")
        UserDefaults.standard.removeObject(forKey: "SavedCountriesData")
        UserDefaults.standard.removeObject(forKey: "playerEnergy")
        UserDefaults.standard.removeObject(forKey: "playerEnergyMax")
        UserDefaults.standard.removeObject(forKey: "playerIncome")
    }
}
