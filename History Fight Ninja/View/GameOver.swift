//
//  GameOver.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 06.04.2024.
//

import Foundation
import GameKit
import SpriteKit

class GameOver: SKScene {
    
    override func didMove(to view: SKView) {
        let device = UIDevice.current
        if device.userInterfaceIdiom == .pad {
            view.scene?.size = CGSize(width: 1334, height: 750)
            view.scene?.scaleMode = .aspectFit
        } else if device.userInterfaceIdiom == .phone {
            view.scene?.size = CGSize(width: 1334, height: 750)
            view.scene?.scaleMode = .aspectFill
        } else {
            view.scene?.size = CGSize(width: 1334, height: 750)
            view.scene?.scaleMode = .aspectFill
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let game = GameScene(fileNamed: "game")
        view?.presentScene(game)
    }
}
