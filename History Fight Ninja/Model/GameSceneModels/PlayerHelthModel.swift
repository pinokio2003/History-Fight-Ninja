//
//  PlayerHelthModel.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 17.09.2024.
//

import SpriteKit

class PlayerHealth {
    private var healthSprites: [SKSpriteNode] = []
    private var currentHealth: Int
    private let maxHealth: Int
    private let parentNode: SKNode
    private let healthTexture: SKTexture
    private let position: CGPoint
    private let spriteSize: CGFloat
    private let spacing: CGFloat
    
    init(maxHealth: Int, parentNode: SKNode, healthImageName: String, position: CGPoint, spriteSize: CGFloat = 40, spacing: CGFloat = 0) {
        self.maxHealth = maxHealth
        self.currentHealth = maxHealth
        self.parentNode = parentNode
        self.healthTexture = SKTexture(imageNamed: healthImageName)
        self.position = position
        self.spriteSize = spriteSize
        self.spacing = spacing
        setupHealthSprites()
    }
    
    private func setupHealthSprites() {
        for i in 0..<maxHealth {
            let healthSprite = SKSpriteNode(texture: healthTexture)
            healthSprite.size = CGSize(width: spriteSize, height: spriteSize)
            let yPosition = position.y + CGFloat(i) * (spriteSize + spacing)
            healthSprite.position = CGPoint(x: position.x, y: yPosition)
            parentNode.addChild(healthSprite)
            healthSprites.append(healthSprite)
        }
    }
    
    func decreaseHealth() {
        guard currentHealth > 0 else { return }
        currentHealth -= 1
        if let lastHealth = healthSprites.last {
            lastHealth.removeFromParent()
            healthSprites.removeLast()
        }
    }
    
    func increaseHealth() {
        guard currentHealth < maxHealth else { return }
        currentHealth += 1
        
        let newHealth = SKSpriteNode(texture: healthTexture)
        newHealth.size = CGSize(width: spriteSize, height: spriteSize)
        let xPosition = position.x + CGFloat(currentHealth - 1) * (spriteSize + spacing)
        newHealth.position = CGPoint(x: xPosition, y: position.y)
        
        parentNode.addChild(newHealth)
        healthSprites.append(newHealth)
    }
    
    func getCurrentHealth() -> Int {
        return currentHealth
    }
}
