//
//  Streak.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 18.04.2024.
//

import SpriteKit

class Streak: SKNode {
    private let label: SKLabelNode
    
    init(text: String, fontSize: CGFloat) {
        label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        label.fontSize = fontSize
        super.init()
        addChild(label)
        updateText(text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateText(_ newText: String) {
        label.text = newText
        label.fontColor = .red
    }
    
    func showFor(duration: TimeInterval, in scene: SKScene, at position: CGPoint) {
            self.position = position
            self.alpha = 1.0 // Сброс прозрачности
            
            if self.parent == nil {
                scene.addChild(self)
            }
            
            // FadeOut and hide
            let fadeOutAction = SKAction.fadeOut(withDuration: duration)
            let hideAction = SKAction.run { [weak self] in
                self?.isHidden = true
            }
            // combine
            let sequence = SKAction.sequence([fadeOutAction, hideAction])
            self.run(sequence)
        }
}
