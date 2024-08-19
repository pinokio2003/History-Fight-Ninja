//
//  Constants.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 10.07.2024.
//

import UIKit
import SwiftUI

struct Constants {
    static let spawnMinValue = 3
    static let spawnMaxValue = 6
    static let spawnMinX = 20
    static let spawnMaxVelocityX = 300
    static let spawnMinVelocityY = 500
    static let spawnMaxVelocityY = 700
    static let spawnMinAngularVelocity = -5
    static let spawnMaxAngularVelocity = 5
    static let healthBarIncrement = 0.01
    static let enemyHealthBarIncrement = 0.1
    static let streakThreshold = 5
    static let countdownDuration = 3
    static let fadeOutDuration = 0.6
    static let spawnInterval = 2.0
    
    
    struct HealthBar {
        static let size = CGSize(width: 20, height: 250)
        static let heroColor: UIColor = .green
        static let enemyColor: UIColor = .red
        static let backgroundColor: UIColor = .gray
    }
}

//Colors:
let innerPurple = Color(red: 151 / 255, green: 71 / 255, blue: 255 / 255)
let innerGreen = Color(red: 161 / 255, green: 255 / 255, blue: 0 / 255)
