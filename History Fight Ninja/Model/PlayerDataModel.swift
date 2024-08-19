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
    //player data + User Defaults:
    @Published var playerCountry: String = UserDefaults.standard.string(forKey: "playerCountry") ?? "Ukraine" {
        didSet {
            UserDefaults.standard.set(playerCountry, forKey: "playerCountry")
        }
    }
    @Published var playerExperience: Int = UserDefaults.standard.integer(forKey: "playerExperience") {
        didSet {
            UserDefaults.standard.set(playerExperience, forKey: "playerExperience")
        }
    }
    
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
        UserDefaults.standard.removeObject(forKey: "playerCountry")
        UserDefaults.standard.removeObject(forKey: "playerExperience")
        UserDefaults.standard.removeObject(forKey: "SavedCountriesData")
    }
}
