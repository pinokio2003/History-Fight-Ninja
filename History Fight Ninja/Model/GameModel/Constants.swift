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
//Devices
let device = UIDevice.current
//Colors:
let innerPurple = Color(red: 151 / 255, green: 71 / 255, blue: 255 / 255)
let innerGreen = Color(red: 161 / 255, green: 255 / 255, blue: 0 / 255)

//difficlty:
func difficltyLevel(enemyPower: Int, playerPower: Int) -> String {
    let difference = enemyPower - playerPower
    
    switch difference {
        case ..<0:
            return "Easy"
        case 0...30:
            return "Easy"
        case 31...50:
            return "Normal"
        case 51...100:
            return "Hard"
        case 101...150:
            return "Very Hard"
        default :
            return "Impossible"
    }
}

func getColorDifficlty(difficlty: String) -> Color {
    switch difficlty {
        case "Easy":
            return .blue
        case "Normal":
            return .yellow
        case "Hard":
            return .orange
        case "Very Hard":
            return .red
        default:
            return .black
    }
}

func presentContentView<Content: View>(with view: Content) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else { return }
    
    let hostController = UIHostingController(rootView: view)
    let navController = UINavigationController(rootViewController: hostController)
    navController.setNavigationBarHidden(true, animated: false)
    
    UIView.animate(withDuration: 0.5, animations: {
        window.alpha = 0
    }) { _ in
        window.rootViewController = navController
        UIView.animate(withDuration: 0.5) {
            window.alpha = 1
        }
    }
}
