//
//  GameWin.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 17.04.2024.
//

import Foundation
import GameKit
import SpriteKit

class GameWin: SKScene {
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let game = GameScene(fileNamed: "game")
        view?.presentScene(game)
    }
}
