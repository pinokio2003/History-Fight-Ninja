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
    private let mapModel = CountryDataManager.shared
    
    @Published var name: String = "" // enemy
    @Published var isCountrySelected: Bool = false
    @Published var isFightStartButton: Bool = false
    @Published var isAnimationBeforeFight: Bool = false
    @Published var isRestartPushing: Bool = false
    @Published var isDisabled: Bool = false
    @Published var isDisabledSkill : Bool = false
    // If data is consistent:
    @Published var isDataConsistent: Bool = {
        let key = "isDataConsistent"
        if UserDefaults.standard.object(forKey: key) == nil {
            return false
        } else {}
            return UserDefaults.standard.bool(forKey: "isDataConsistent")
    }() {
        didSet {
            UserDefaults.standard.set(isDataConsistent, forKey: "isDataConsistent")
        }
    }
    //For Score:
    @Published var gameTime: Int = 0
    @Published var playerScore: Int = 0
    // For AnimationTableDefeat
    @Published var swing = true
    @Published var stopped = true
//MARK: - player info:
    @Published var playerPower: Int =  {
        let key = "playerPower"
        if UserDefaults.standard.object(forKey: key) == nil {
            return 1 // Return default value if key doesn't exist
        } else {
            return UserDefaults.standard.integer(forKey: key)
        }
        }() {
        didSet {
            UserDefaults.standard.set(playerPower, forKey: "playerPower")
        }
    }
//Player country:
    @Published var playerCountry: String = UserDefaults.standard.string(forKey: "playerCountry") ?? "Ukraine" {
        didSet {
            UserDefaults.standard.set(playerCountry, forKey: "playerCountry")
        }
    }
//Money:
    @Published var playerExperience: Int = UserDefaults.standard.integer(forKey: "playerExperience") { //UserDefaults.standard.integer(forKey: "playerExperience")
        didSet {
            UserDefaults.standard.set(playerExperience, forKey: "playerExperience")
        }
    }
//% to prize after win battle:
    @Published var prizeVictory: Int = UserDefaults.standard.integer(forKey: "prizeVictory") {
        didSet {
            UserDefaults.standard.set(prizeVictory, forKey: "prizeVictory")
        }
    }
//Income:
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
//Attack:
    @Published var playerAttack: Int = { //UserDefaults.standard.integer(forKey: "playerAttack")
        let key = "playerAttack"
        if UserDefaults.standard.object(forKey: key) == nil {
            return 1
        } else {
            return UserDefaults.standard.integer(forKey: key)
        }
    }() {
        didSet {
            UserDefaults.standard.set(playerAttack, forKey: "playerAttack")
        }
    }
//Health:
    @Published var playerHealth: Int = {
        let key = "playerHealth"
        if UserDefaults.standard.object(forKey: key) == nil {
            return 3 // Return default value if key doesn't exist
        } else {
            return UserDefaults.standard.integer(forKey: key)
        }
    }() {
        didSet {
            UserDefaults.standard.set(playerHealth, forKey: "playerHealth")
        }
    }
//Max streak:
    @Published var maxStreak: Int = {
        let key = "maxStreak"
        if UserDefaults.standard.object(forKey: key) == nil {
            return 2 // Return default value if key doesn't exist
        } else {
            return UserDefaults.standard.integer(forKey: key)
        }
    }() {
        didSet {
            UserDefaults.standard.set(maxStreak, forKey: "maxStreak")
        }
    }
//Enegy (resurce for attack):
    @Published var playerEnergy: Int = 4 { // UserDefaults.standard.integer(forKey: "playerEnergy")
        didSet {
            UserDefaults.standard.set(playerEnergy, forKey: "playerEnergy")
        }
    }
//Additional timer:
    @Published var additionalTimer: Bool = { // UserDefaults.standard.integer(forKey: "playerEnergy")
        let key = "additionalTimer"
        if UserDefaults.standard.object(forKey: key) == nil {
            return false
        } else {
            return UserDefaults.standard.bool(forKey: key)
        } }() {
        didSet {
            UserDefaults.standard.set(additionalTimer, forKey: "additionalTimer")
        }
    }
//Badaboom
        @Published var badaBoom: Bool = { // UserDefaults.standard.integer(forKey: "playerEnergy")
            let key = "badaBoom"
            if UserDefaults.standard.object(forKey: key) == nil {
                return false
            } else {
                return UserDefaults.standard.bool(forKey: key)
            } }() {
            didSet {
                UserDefaults.standard.set(additionalTimer, forKey: "badaBoom")
            }
        }
//Restore Health
    @Published var restoreHealth: Bool = {
        let key = "restoreHealth"
        if UserDefaults.standard.object(forKey: key) == nil {
            return false
        } else {
            return UserDefaults.standard.bool(forKey: key)
        }
    }() {
        didSet {
            UserDefaults.standard.setValue(restoreHealth, forKey: "restoreHealth")
        }
    }
//Max Enegy (resurce for attack):
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
        mapModel.loadDefaultCountriesData()
        playerExperience = 6000
        playerEnergyMax = 5
        playerIncome = 5
        maxStreak = 2
        playerHealth = 3
        playerPower = 1
        additionalTimer = false
        badaBoom = false
        restoreHealth = false
        isDataConsistent = false
        UserDefaults.standard.removeObject(forKey: "isDataConsistent")
        UserDefaults.standard.removeObject(forKey: "playerCountry")
        UserDefaults.standard.removeObject(forKey: "playerExperience")
        UserDefaults.standard.removeObject(forKey: "playerAttack")
        UserDefaults.standard.removeObject(forKey: "playerHealth")
        UserDefaults.standard.removeObject(forKey: "SavedCountriesData")
        UserDefaults.standard.removeObject(forKey: "playerEnergy")
        UserDefaults.standard.removeObject(forKey: "playerEnergyMax")
        UserDefaults.standard.removeObject(forKey: "playerIncome")
        UserDefaults.standard.removeObject(forKey: "maxStreak")
        UserDefaults.standard.removeObject(forKey: "playerPower")
        UserDefaults.standard.removeObject(forKey: "additionalTimer")
    }
}
