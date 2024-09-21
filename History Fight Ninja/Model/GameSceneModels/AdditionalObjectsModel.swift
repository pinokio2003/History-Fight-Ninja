//
//  AdditionalObjectsModel.swift
//  History Fight Ninja
//
//  Created by Anatolii Kravchuk on 17.09.2024.
//

import SpriteKit
import GameplayKit

class AdditionalObjectsModel {
    let additionalTimeTexture: SKTexture
    let badaboomTexture: SKTexture
    let restoreHealthTexture: SKTexture
    let objectSize = CGSize(width: 100, height: 100)
    
    private var lastSpawnTime: TimeInterval = 0
    private let minSpawnInterval: TimeInterval = 10 // Минимальный интервал спавна в секундах
    
    struct Constants {
        static let spawnMinX = 50
        static let spawnMinVelocityY = 100
        static let spawnMaxVelocityY = 300
        static let spawnMinAngularVelocity = -5
        static let spawnMaxAngularVelocity = 5
    }
    
    init() {
        additionalTimeTexture = SKTexture(imageNamed: "additionalTime")
        badaboomTexture = SKTexture(imageNamed: "badaBoom")
        restoreHealthTexture = SKTexture(imageNamed: "restoreHealth")
    }
    
    func createAdditionalTimeSprite() -> SKSpriteNode {
        let sprite = SKSpriteNode(texture: additionalTimeTexture, size: objectSize)
        sprite.name = "additionalTimeTexture"
        sprite.physicsBody = SKPhysicsBody(rectangleOf: objectSize)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.allowsRotation = true
        sprite.zPosition = 10
        return sprite
    }
    
    func createBadaboomSprite() -> SKSpriteNode {
        let sprite = SKSpriteNode(texture: badaboomTexture, size: objectSize)
        sprite.name = "badaBoom"
        sprite.physicsBody = SKPhysicsBody(rectangleOf: objectSize)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.allowsRotation = true
        sprite.zPosition = 10
        return sprite
    }
    
    func createRestoreHealth() -> SKSpriteNode {
        let sprite = SKSpriteNode(texture: restoreHealthTexture, size: objectSize)
        sprite.name = "restoreHealth"
        sprite.physicsBody = SKPhysicsBody(rectangleOf: objectSize)
        sprite.physicsBody?.affectedByGravity = false
        sprite.physicsBody?.allowsRotation = true
        sprite.zPosition = 10
        return sprite
    }
    
    func shouldSpawnAdditionalObject(currentTime: TimeInterval, isActiveAdditionalObject: Bool) -> Bool {
        if currentTime - lastSpawnTime >= minSpawnInterval && isActiveAdditionalObject == true {
            if Double.random(in: 0...1) < 0.2 {
                lastSpawnTime = currentTime
                return true
            }
        }
        return false
    }

    func spawnAdditionalSprites(in scene: SKScene, count: Int, sprite: SKSpriteNode) {
        for _ in 0..<count {
            let sprite = sprite
            sprite.position = CGPoint(x: CGFloat(GKRandomDistribution(lowestValue: Constants.spawnMinX, highestValue: Int(scene.size.width)).nextInt()), y: -50)
            scene.addChild(sprite)
            
            if sprite.position.x < scene.size.width / 2 {
                sprite.physicsBody?.velocity.dx = CGFloat(arc4random_uniform(300))
            } else {
                sprite.physicsBody?.velocity.dx = CGFloat(-200)
            }
            
            sprite.physicsBody?.velocity.dy = CGFloat(GKRandomDistribution(lowestValue: Constants.spawnMinVelocityY, highestValue: Constants.spawnMaxVelocityY).nextInt())
            sprite.physicsBody?.angularVelocity = CGFloat(GKRandomDistribution(lowestValue: Constants.spawnMinAngularVelocity, highestValue: Constants.spawnMaxAngularVelocity).nextInt())
        }
    }
    
    func createSmoothDamageEffect(for scene: SKScene) -> SKSpriteNode {
            let screenSize = scene.size
            let effectNode = SKSpriteNode(color: .clear, size: screenSize)
            effectNode.position = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
            
            // Создаем градиентную текстуру
            let gradientTexture = createGradientTexture(size: screenSize)
            let gradientNode = SKSpriteNode(texture: gradientTexture)
            gradientNode.position = CGPoint(x: 0, y: 0)
            effectNode.addChild(gradientNode)
            
            // Создаем маску с закругленными углами
            let cornerRadius: CGFloat = 20
            let maskPath = UIBezierPath(roundedRect: effectNode.frame.insetBy(dx: cornerRadius, dy: cornerRadius),
                                        cornerRadius: cornerRadius)
            let maskShape = SKShapeNode(path: maskPath.cgPath)
            maskShape.fillColor = .white
            
            let maskNode = SKSpriteNode(color: .black, size: screenSize)
            maskNode.addChild(maskShape)
            
//            effectNode.maskNode = maskNode
            effectNode.alpha = 0 // Начальная прозрачность
            
            return effectNode
        }
        
        private func createGradientTexture(size: CGSize) -> SKTexture {
            let renderer = UIGraphicsImageRenderer(size: size)
            let image = renderer.image { context in
                let colors = [UIColor.clear.cgColor,
                              UIColor.red.withAlphaComponent(0.5).cgColor,
                              UIColor.red.withAlphaComponent(0.5).cgColor,
                              UIColor.clear.cgColor] as CFArray
                let colorSpace = CGColorSpaceCreateDeviceRGB()
                let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: [0, 0.3, 0.7, 1])!
                context.cgContext.drawLinearGradient(gradient,
                                                     start: CGPoint(x: 0, y: 0),
                                                     end: CGPoint(x: size.width, y: 0),
                                                     options: [])
            }
            return SKTexture(image: image)
        }
    
}
