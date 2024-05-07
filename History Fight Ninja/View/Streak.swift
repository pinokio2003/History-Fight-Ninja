//
//  Streak.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 18.04.2024.
//

import SpriteKit

class Streak: SKNode {
    
    private var labelNode: SKLabelNode!
    
    init(text: String, fontSize: CGFloat) {
        super.init()
        
        labelNode = SKLabelNode(text: text)
        labelNode.fontColor = .red
        labelNode.fontName = "MarkerFelt-Wide"
        labelNode.fontSize = fontSize
        //shadows
        let effectNode = SKEffectNode()
        effectNode.shouldRasterize = true
        effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 12.0])
        
        // Добавляем тень вокруг текста
        let shadow = SKLabelNode(text: text)
        shadow.position = CGPoint(x: -2, y: -2)
        shadow.fontColor = UIColor(red: 1, green: 0.8, blue: 0, alpha: 1)
        shadow.fontSize = fontSize
        
        effectNode.addChild(shadow)
        
        labelNode.addChild(effectNode)
        
        addChild(labelNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showFor(duration: TimeInterval, in scene: SKScene, at position: CGPoint) {
        self.position = position
        scene.addChild(self)
        // FadeOut and remove
        let fadeOutAction = SKAction.fadeOut(withDuration: duration)
        let removeAction = SKAction.removeFromParent()
        // combine
        let sequence = SKAction.sequence([fadeOutAction, removeAction])
        self.run(sequence)
    }
}

