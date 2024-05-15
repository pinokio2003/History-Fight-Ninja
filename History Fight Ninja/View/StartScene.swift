//
//  StartScene.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 09.05.2024.
//

import SwiftUI
import SpriteKit
import GameKit

class StartScene: SKScene {
    
    var startButton = SKLabelNode()
    let fadeOut = SKAction.fadeOut(withDuration: 0.8)
    let fadeIn = SKAction.fadeIn(withDuration: 0.8)
    
    override func didMove(to view: SKView) {
        view.scene?.size = CGSize(width: 1334, height: 750)
        view.scene?.scaleMode = .aspectFill
        
        startButton = childNode(withName: "startButton") as! SKLabelNode
        
        let sequence = SKAction.sequence([fadeOut, fadeIn])
        startButton.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let startNode = atPoint(location)
            let game = GameScene(fileNamed: "game")
            
            if startNode.name == "startButton" {
                view?.presentScene(game)

            }
        }
    }
}
