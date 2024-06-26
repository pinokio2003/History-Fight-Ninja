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
    
    @Published var name: String = "" // enemy
    @Published var isCountrySelected: Bool = false
    @Published var isFightStartButton: Bool = false
    @Published var isAnimationBeforeFight: Bool = false
    @Published var isRestartPushing: Bool = false
    @Published var isDisabled: Bool = false
    //player data:
    @Published var playerCountry: String = "Ukraine"
    @Published var enemyName: String = ""
    @Published var allyArray: [String] = []
    
    private init() {}
    
    func resetAllData() {
        isCountrySelected = false
        isFightStartButton = false
        isRestartPushing = false
        enemyName = ""
    }
}
